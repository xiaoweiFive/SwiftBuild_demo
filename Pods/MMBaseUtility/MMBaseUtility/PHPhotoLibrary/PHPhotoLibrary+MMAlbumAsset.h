//
//  PHPhotoLibrary+MMAlbumAsset.h
//  MMBaseUtility
//
//  Created by sunfei on 2018/11/27.
//

#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface PHPhotoLibrary (MMAlbumAsset)

/// 获取相册权限
/// 如果已经允许或部分允许，返回YES，已经拒绝、家长限制、未授权返回NO，否则弹起弹框询问用户。
/// @param completion 权限的回调，注意回调线程不是主线程
+ (BOOL)mm_requestAuthorization;
+ (BOOL)mm_requestAuthorizationWithCompletion:(void(^)(PHAuthorizationStatus status))completion;
+ (BOOL)mm_requestAuthorizationShowAlert:(BOOL)alert completion:(void(^)(PHAuthorizationStatus status))completion;
+ (BOOL)mm_requestAuthorizationNoAlertWithCompletion:(void(^)(PHAuthorizationStatus status))completion;
+ (void)mm_savePhotoNoAlert:(UIImage *)image toAlbumWithName:(NSString *)albumName completion:(void(^)(PHFetchResult<PHAsset *> *, NSError *))completion;
/// 根据相册名查询相册
/// @param albumName 相册名
+ (nullable PHAssetCollection *)mm_findAlbumWithName:(NSString *)albumName;

/// 创建相册，注意这里不会判断是否有重名的相册。需要用户自己在外部判断
/// @param albumName 相册名
/// @param completion 创建成功的回调，注意回调线程不是主线程
+ (void)mm_createAlbumWithName:(NSString *)albumName completion:(void(^)(PHAssetCollection * _Nullable collection, NSError *error))completion;


/// 保存图片到指定相册
/// @param path 图片路径
/// @param albumName 相册名
/// @param completion 结果回调，注意回调线程不是主线程
+ (void)mm_savePhotoAtPath:(NSURL *)path
           toAlbumWithName:(NSString *)albumName
                completion:(void(^ _Nullable)(PHFetchResult<PHAsset *> * _Nullable fetchResult, NSError * _Nullable error))completion;


/// 保存图片到指定相册
/// @param image 图片对象
/// @param albumName 相册名
/// @param completion 结果回调，注意回调线程不是主线程
+ (void)mm_savePhoto:(UIImage *)image toAlbumWithName:(NSString *)albumName completion:(void(^ _Nullable)(PHFetchResult<PHAsset *> * _Nullable fetchResult, NSError * _Nullable error))completion;


/// 保存多张图片到指定相册
/// @param images 图片数组
/// @param albumName 相册名
/// @param completion 结果回调，注意回调线程不是主线程
+ (void)mm_savePhotos:(NSArray<UIImage *> *)images toAlbumWithName:(NSString *)albumName completion:(void(^ _Nullable)(PHFetchResult<PHAsset *> * _Nullable fetchResult, NSError * _Nullable error))completion;


/// 保存视频到指定相册
/// @param url 视频路径URL
/// @param albumName 相册名
/// @param completion 结果回调，注意回调线程不是主线程
+ (void)mm_saveVideoAtPath:(NSURL *)url toAlbumWithName:(NSString *)albumName completion:(void(^ _Nullable)(PHFetchResult<PHAsset *> * _Nullable fetchResult, NSError * _Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
