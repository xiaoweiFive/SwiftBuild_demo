//
//  NSFileManager+Paths.m
//  IOS-Categories
//
//  Created by Jakey on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "NSFileManager+Paths.h"
#include <sys/xattr.h>

@implementation NSFileManager (MDPaths)

+ (NSURL *)md_URLForDirectory:(NSSearchPathDirectory)directory
{
    return [self.defaultManager URLsForDirectory:directory inDomains:NSUserDomainMask].lastObject;
}

+ (NSString *)md_pathForDirectory:(NSSearchPathDirectory)directory
{
    return NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES).firstObject;
}

+ (NSURL *)md_documentsURL
{
    return [self md_URLForDirectory:NSDocumentDirectory];
}

+ (NSString *)md_documentsPath
{
    return [self md_pathForDirectory:NSDocumentDirectory];
}

+ (NSURL *)md_libraryURL
{
    return [self md_URLForDirectory:NSLibraryDirectory];
}

+ (NSString *)md_libraryPath
{
    return [self md_pathForDirectory:NSLibraryDirectory];
}

+ (NSURL *)md_cachesURL
{
    return [self md_URLForDirectory:NSCachesDirectory];
}

+ (NSString *)md_cachesPath
{
    return [self md_pathForDirectory:NSCachesDirectory];
}

+ (NSURL *)md_applicationSupportURL
{
    return [self md_URLForDirectory:NSApplicationSupportDirectory];
}

+ (NSString *)md_applicationSupportPath
{
    return [self md_pathForDirectory:NSApplicationSupportDirectory];
}

+ (NSURL *)md_tempURL
{
    NSString *path = NSTemporaryDirectory();
    return [NSURL fileURLWithPath:path];
}

+ (NSString *)md_tempPath
{
    return NSTemporaryDirectory();
}

@end
