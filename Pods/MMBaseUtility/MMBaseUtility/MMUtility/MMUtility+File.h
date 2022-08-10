//
//  MMUtility+File.h
//  MMBaseUtility
//
//  Created by yzkmac on 2020/5/7.
//

#import "MMUtility.h"

NS_ASSUME_NONNULL_BEGIN

@class MMUtilityFolderInfoModel;

@interface MMUtility (File)

/// 根据指定路径，判断是否存在文件夹，不存在就创建文件夹；如果是文件则删除，然后创建文件夹。
/// @param path 指定路径
+ (void)checkOrCreateDirectoryAtPath:(NSString *)path;

/**
 遍历指定目录
 @param path 指定目录
 @param block 目录内容回调
 */
+ (void)enumerateFolderPath:(NSString *)path UsingBlock:(void (^)(NSString *fileName, NSString *fullPath, NSUInteger idx, BOOL isDir))block;

/**
 获取沙盒指定目录的大小，及子目录的大小, 比较耗时，只做调试用
 @param path 指定目录
 @param deepth 提取子目录的深度
 @param top 指定获取排名大小前几的目录或文件
 @return MDFolderInfoModel
 */
+ (MMUtilityFolderInfoModel *)folderInfoAtPath:(NSString *)path deepth:(NSInteger)deepth top:(NSInteger)top;

/**
 获取指定目录或文件的大小。若权限不足、中止或发生错误，返回已读到的大小。
 @param path 指定路径
 @return 占用大小，单位字节
 */
+ (unsigned long long)folderSizeAtPath:(NSString *)path;

/**
 获取单个文件的大小
 @param path 指定路径
 @return 占用大小，单位字节
 */
+ (long long)fileSizeAtPath:(NSString *)path;

@end

@interface MMUtilityFolderInfoModel : NSObject
@property (nonatomic, copy)   NSString *name;
@property (nonatomic, assign) BOOL isDir;
@property (nonatomic, assign) long long size;
@property (nonatomic, strong, nullable) NSArray <MMUtilityFolderInfoModel *> *subs;
- (NSDictionary *)jsonDic;
@end


NS_ASSUME_NONNULL_END
