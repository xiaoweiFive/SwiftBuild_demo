//
//  MMUtility+File.m
//  MMBaseUtility
//
//  Created by yzkmac on 2020/5/7.
//

#import "MMUtility+File.h"
#include <sys/stat.h>

@implementation MMUtility (File)

+ (void)checkOrCreateDirectoryAtPath:(NSString *)path
{
    if (nil == path) {
        return;
    }
    
    BOOL isDir = NO;
    BOOL exist = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir];
    if (!exist) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:NULL];
    } else if (!isDir) {
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:NULL];
    }
}


+ (void)enumerateFolderPath:(NSString *)path UsingBlock:(void (^)(NSString *fileName, NSString *fullPath, NSUInteger idx, BOOL isDir))block
{
    NSArray *tempArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    [tempArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *fileName = obj;
        BOOL isDir;
        NSString *fullPath = [path stringByAppendingPathComponent:fileName];
        if ([[NSFileManager defaultManager] fileExistsAtPath:fullPath isDirectory:&isDir]) {
            block(fileName, fullPath, idx, isDir);
        }
    }];
}


+ (MMUtilityFolderInfoModel *)folderInfoAtPath:(NSString *)path deepth:(NSInteger)deepth top:(NSInteger)top
{
    BOOL isDir;
    BOOL checkSubs = deepth > 0;
    BOOL exist = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir];
    if (!exist) {
        return nil;
    }
    
    MMUtilityFolderInfoModel *info = [MMUtilityFolderInfoModel new];
    info.isDir = isDir;
    info.name = [path lastPathComponent];
    
    __block long long size = 0;
    NSMutableArray *subs = checkSubs ? @[].mutableCopy : nil;
    
    [self enumerateFolderPath:path UsingBlock:^(NSString *fileName, NSString *fullPath, NSUInteger idx, BOOL isDir) {
        if (isDir)
        {
            MMUtilityFolderInfoModel *model = [self folderInfoAtPath:fullPath deepth:deepth - 1 top:top];
            size += model.size;
            if (model) {
                [subs addObject:model];
            }
        }
        else
        {
            long long s = [self fileSizeAtPath:fullPath];
            size += s;
            if (checkSubs)
            {
                MMUtilityFolderInfoModel *model = [MMUtilityFolderInfoModel new];
                model.name = fileName;
                model.size = s;
                model.isDir = isDir;
                if (model) {
                    [subs addObject:model];
                }
            }
        }
    }];
    
    if (top > 0 && subs.count > 0)
    {
        [subs sortUsingSelector:@selector(compare:)];
        if (top < subs.count)
        {
            [subs removeObjectsInRange: NSMakeRange(0, subs.count - top)];
        }
    }
    info.subs = subs;
    info.size = size;
    return info;
}

+ (unsigned long long)folderSizeAtPath:(NSString *)path
{
    unsigned long long folderSize = 0;
    
    @try {
        BOOL isDirectory = NO;
        if (![[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory]) {
            return 0;
        }
        
        if (!isDirectory) {
            return [self fileSizeAtPath:path];
        }
        
        NSURL *folderURL = [NSURL fileURLWithPath:path];
        [self getAllocatedSize:&folderSize ofDirectoryAtURL:folderURL error:NULL];
    } @catch (NSException *exception) { }
    
    return folderSize;
}

+ (BOOL)getAllocatedSize:(unsigned long long *)size ofDirectoryAtURL:(NSURL *)directoryURL error:(NSError * __autoreleasing *)error
{
    //NSParameterAssert(size != NULL);
    //NSParameterAssert(directoryURL != nil);

    // We'll sum up content size here:
    unsigned long long accumulatedSize = 0;

    // prefetching some properties during traversal will speed up things a bit.
    NSArray *prefetchedProperties = @[
        NSURLIsRegularFileKey,
        NSURLFileAllocatedSizeKey,
        NSURLTotalFileAllocatedSizeKey,
    ];

    // The error handler simply signals errors to outside code.
    __block BOOL errorDidOccur = NO;
    BOOL (^errorHandler)(NSURL *, NSError *) = ^(NSURL *url, NSError *localError) {
        if (error != NULL)
            *error = localError;
        errorDidOccur = YES;
        return NO;
    };

    // We have to enumerate all directory contents, including subdirectories.
    NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager] enumeratorAtURL:directoryURL
                                                             includingPropertiesForKeys:prefetchedProperties
                                                                                options:(NSDirectoryEnumerationOptions)0
                                                                           errorHandler:errorHandler];

    // Start the traversal:
    for (NSURL *contentItemURL in enumerator) {
        @autoreleasepool {
            // Bail out on errors from the errorHandler.
            if (errorDidOccur)
                return NO;

            // Get the type of this item, making sure we only sum up sizes of regular files.
            NSNumber *isRegularFile;
            if (! [contentItemURL getResourceValue:&isRegularFile forKey:NSURLIsRegularFileKey error:error])
                return NO;
            if (! [isRegularFile boolValue])
                continue; // Ignore anything except regular files.

            // To get the file's size we first try the most comprehensive value in terms of what the file may use on disk.
            // This includes metadata, compression (on file system level) and block size.
            NSNumber *fileSize;
            if (! [contentItemURL getResourceValue:&fileSize forKey:NSURLTotalFileAllocatedSizeKey error:error])
                return NO;

            // In case the value is unavailable we use the fallback value (excluding meta data and compression)
            // This value should always be available.
            if (fileSize == nil) {
                if (! [contentItemURL getResourceValue:&fileSize forKey:NSURLFileAllocatedSizeKey error:error])
                    return NO;

                //NSAssert(fileSize != nil, @"huh? NSURLFileAllocatedSizeKey should always return a value");
            }

            // We're good, add up the value.
            accumulatedSize += [fileSize unsignedLongLongValue];
        }
    }

    // Bail out on errors from the errorHandler.
    if (errorDidOccur)
        return NO;

    // We finally got it.
    *size = accumulatedSize;
    return YES;
}

+ (long long)fileSizeAtPath:(NSString *)path
{
    struct stat st;
    if (lstat([path cStringUsingEncoding:NSUTF8StringEncoding], &st) == 0) {
        return st.st_size;
    }
    return 0;
}

@end




@implementation MMUtilityFolderInfoModel

- (NSString *)description
{
    NSString *size = [NSByteCountFormatter stringFromByteCount:_size countStyle:NSByteCountFormatterCountStyleFile];
    NSString *s =  [NSString stringWithFormat:@"name: %@, size: %@, subs: %@", _name, size, _subs];
    return s;
}

- (NSString *)debugDescription
{
    NSString *size = [NSByteCountFormatter stringFromByteCount:_size countStyle:NSByteCountFormatterCountStyleFile];
    NSString *s =  [NSString stringWithFormat:@"name: %@, \r size: %@, \r isDir: %d, \r subs: %@ \r", _name, size, _isDir, [_subs debugDescription]];
    return s;
}

- (NSComparisonResult)compare:(MMUtilityFolderInfoModel *)other
{
    if (other.size == self.size) {
        return NSOrderedSame;
    }
    if (other.size > self.size) {
        return NSOrderedAscending;
    }
    return NSOrderedDescending;
}

- (NSDictionary *)jsonDic
{
    NSMutableDictionary *dic = @{}.mutableCopy;
    [dic setValue:_name forKey:@"name"];
    NSString *size = [NSByteCountFormatter stringFromByteCount:_size countStyle:NSByteCountFormatterCountStyleFile];
    [dic setValue:size forKey:@"size"];
    
    if (_subs.count > 0) {
        NSMutableArray *arr = @[].mutableCopy;
        for (MMUtilityFolderInfoModel *m in self.subs) {
            [arr addObject:[m jsonDic]];
        }
        [dic setValue:arr forKey:@"subs"];
    }
    
    return dic;
}

- (NSString *)jsonString
{
    NSDictionary *dic = [self jsonDic];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:kNilOptions error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonStr;
}

@end
