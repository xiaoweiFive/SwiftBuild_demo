//
//  PHPhotoLibrary+MMAlbumAsset.m
//  MMBaseUtility
//
//  Created by sunfei on 2018/11/27.
//

#import "PHPhotoLibrary+MMAlbumAsset.h"
#import <UIKit/UIKit.h>
@implementation PHPhotoLibrary (MMAlbumAsset)

+ (BOOL)mm_requestAuthorizationWithCompletion:(void(^)(PHAuthorizationStatus status))completion {
    return [self mm_requestAuthorizationShowAlert:YES completion:completion];
}

+ (BOOL)mm_requestAuthorizationNoAlertWithCompletion:(void(^)(PHAuthorizationStatus status))completion {
    return [self mm_requestAuthorizationShowAlert:NO completion:completion];
}

+ (BOOL)mm_requestAuthorization {
    return [self mm_requestAuthorizationShowAlert:YES completion:nil];
}

+ (BOOL)mm_requestAuthorizationShowAlert:(BOOL)alert completion:(void(^)(PHAuthorizationStatus status))completion {
    if (PHPhotoLibrary.authorizationStatus == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (completion) {
                completion(status);
            }
        }];
        return NO;
    } else if (PHPhotoLibrary.authorizationStatus == PHAuthorizationStatusRestricted
               || PHPhotoLibrary.authorizationStatus == PHAuthorizationStatusDenied) {
        if (completion) {
            completion(PHPhotoLibrary.authorizationStatus);
        }
        if (alert) {
            [self _openSettingAlert:@"开启相册权限" message:@"请在系统设置中开启相册权限"];
        }
        return NO;
    }
    if (completion) {
        completion(PHPhotoLibrary.authorizationStatus);
    }
    return YES;
}

#pragma photo
+ (void)mm_savePhotoAtPath:(NSURL *)path
           toAlbumWithName:(NSString *)albumName
                completion:(void(^)(PHFetchResult<PHAsset *> *, NSError *))completion {
    void(^save)(void) = ^{
        PHAssetCollection *album = [self mm_findAlbumWithName:albumName];
        [self _savePhotoAtPath:path toAlbum:album completion:completion];
    };
    [self mm_requestAuthorizationNoAlertWithCompletion:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            save();
        } else {
            if (status == PHAuthorizationStatusDenied) {
                [PHPhotoLibrary _openSettingAlert:@"保存失败" message:@"图片保存失败，请开启系统照片选项"];
            } else if (status != PHAuthorizationStatusNotDetermined) {
                NSLog(@"没获取权限呢");
            }
            NSError *error = [NSError errorWithDomain:@"com.album.authentication.mm"
                                                 code:-1
                                             userInfo:nil];
            completion ? completion(nil, error) : nil;
        }
    }];
}

+ (void)_savePhotoAtPath:(NSURL *)path
                 toAlbum:(PHAssetCollection *)album
              completion:(void(^)(PHFetchResult<PHAsset *> *, NSError *))completion {
    __block PHObjectPlaceholder *placeholder = nil;
    
    [PHPhotoLibrary.sharedPhotoLibrary performChanges:^{
        if (album) {
            [self _haveAlbumSaveImagePath:path toAlbum:album];
        } else {
            [self _noAlbumSaveImagePath:path];
        }
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        [PHPhotoLibrary saveOneCompletion:completion success:success placeholder:placeholder error:error];
    }];
}

+ (void)mm_savePhoto:(UIImage *)image toAlbumWithName:(NSString *)albumName completion:(void(^)(PHFetchResult<PHAsset *> *, NSError *))completion {
    [self mm_savePhotos:@[image] toAlbumWithName:albumName completion:completion];
}

+ (void)mm_savePhotos:(NSArray<UIImage *> *)images toAlbumWithName:(NSString *)albumName completion:(void(^)(PHFetchResult<PHAsset *> *, NSError *))completion {
    [self mm_requestAuthorizationNoAlertWithCompletion:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            [PHPhotoLibrary _savePhotos:images toAlbumWithName:albumName completion:completion];
        } else {
            if (status == PHAuthorizationStatusDenied) {
                [PHPhotoLibrary _openSettingAlert:@"保存失败" message:@"图片保存失败，请开启系统照片选项"];
            } else if (status != PHAuthorizationStatusNotDetermined) {
                NSLog(@"没获取权限呢");
            }
            NSError *error = [NSError errorWithDomain:@"com.album.authentication.mm"
                                                 code:-1
                                             userInfo:nil];
            completion ? completion(nil, error) : nil;
        }
        
    }];
}

+ (void)mm_savePhotoNoAlert:(UIImage *)image toAlbumWithName:(NSString *)albumName completion:(void(^)(PHFetchResult<PHAsset *> *, NSError *))completion {
    [self mm_savePhotosNoAlert:@[image] toAlbumWithName:albumName completion:completion];
}

+ (void)mm_savePhotosNoAlert:(NSArray<UIImage *> *)images toAlbumWithName:(NSString *)albumName completion:(void(^)(PHFetchResult<PHAsset *> *, NSError *))completion {
    [self mm_requestAuthorizationNoAlertWithCompletion:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            [PHPhotoLibrary _savePhotos:images toAlbumWithName:albumName completion:completion];
        } else {
            NSError *error = [NSError errorWithDomain:@"com.album.authentication.mm"
                                                 code:-1
                                             userInfo:nil];
            completion ? completion(nil, error) : nil;
        }
    }];
}

+ (PHAssetCollection *)mm_findAlbumWithName:(NSString *)albumName  {
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.predicate = [NSPredicate predicateWithFormat:@"title = %@", albumName];
    PHFetchResult *result = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAny options:options];
    if (!result.firstObject) {
        __block NSString *albumID = nil;
        [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
            albumID = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:albumName].placeholderForCreatedAssetCollection.localIdentifier;
        } error:nil];
        if (albumID == nil) return nil;
        return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[albumID] options:nil].firstObject;
    }
    return result.firstObject;
}

+ (void)mm_createAlbumWithName:(NSString *)albumName completion:(void(^)(PHAssetCollection * _Nullable collection, NSError *))completion {
    __block PHObjectPlaceholder *placeHolder = nil;
    [PHPhotoLibrary.sharedPhotoLibrary performChanges:^{
        PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:albumName];
        placeHolder = request.placeholderForCreatedAssetCollection;
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (completion) {
            if (success && placeHolder) {
                PHFetchResult *result = [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[placeHolder.localIdentifier] options:nil];
                completion(result.firstObject, nil);
            } else {
                completion(nil, error);
            }
        }
    }];
}

+ (void)_savePhotos:(NSArray<UIImage *> *)images toAlbumWithName:(NSString *)albumName completion:(void(^)(PHFetchResult<PHAsset *> *, NSError *))completion {
    PHAssetCollection *album = [self mm_findAlbumWithName:albumName];
    [self _saveBatchImages:images toAlbum:album completion:completion];
}

+ (void)_saveBatchImages:(NSArray<UIImage *> *)images toAlbum:(PHAssetCollection *)album completion:(void(^)(PHFetchResult<PHAsset *> *, NSError *))completion {

    __block NSMutableArray<PHObjectPlaceholder *> *placeholders = [NSMutableArray array];
    
    [PHPhotoLibrary.sharedPhotoLibrary performChanges:^{
        if (!album) {
            placeholders = [self _noAlbumSaveImages:images];
        } else {
            placeholders = [self _haveAlbumSaveImages:images toAlbum:album];
        }
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (completion) {
            if (success && placeholders.count > 0) {
                NSMutableArray<NSString *> *identifiers = [NSMutableArray array];
                for (PHObjectPlaceholder *placeholder in placeholders) {
                    [identifiers addObject:placeholder.localIdentifier];
                }
                PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsWithLocalIdentifiers:identifiers options:nil];
                completion(assets, nil);
            } else {
                completion(nil, error);
            }
        }
    }];
}

+ (NSMutableArray<PHObjectPlaceholder *> *)_noAlbumSaveImages:(NSArray<UIImage *> *)images {
    NSMutableArray<PHObjectPlaceholder *> *placeholders = [NSMutableArray array];
    for (UIImage *image in images) {
        PHObjectPlaceholder *placeholder = [self _placeholderImage:image];
        if (!placeholder) continue;
        [placeholders addObject:placeholder];
    }
    return placeholders;
}

+ (NSMutableArray<PHObjectPlaceholder *> *)_haveAlbumSaveImages:(NSArray<UIImage *> *)images toAlbum:(PHAssetCollection *)album {
    NSMutableArray<PHObjectPlaceholder *> *placeholders = [NSMutableArray array];
    PHAssetCollectionChangeRequest *albumChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:album];
    for (UIImage *image in images) {
        PHObjectPlaceholder *placeholder = [self _placeholderImage:image];
        if (!placeholder) continue;
        [placeholders addObject:placeholder];
    }
    [albumChangeRequest addAssets:placeholders];
    return placeholders;
}

+ (PHObjectPlaceholder *)_noAlbumSaveImagePath:(NSURL *)path {
    PHObjectPlaceholder *placeholder = [self _placeholderImagePath:path];
    if (!placeholder) return nil;
    return placeholder;
}

+ (PHObjectPlaceholder *)_haveAlbumSaveImagePath:(NSURL *)path toAlbum:(PHAssetCollection *)album {
    PHAssetCollectionChangeRequest *albumChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:album];
    PHObjectPlaceholder *placeholder = [self _placeholderImagePath:path];
    if (!placeholder) return nil;
    [albumChangeRequest addAssets:@[placeholder]];
    return placeholder;
}

+ (PHObjectPlaceholder *)_placeholderImage:(UIImage *)image {
    PHAssetChangeRequest *createAssetRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
    return createAssetRequest.placeholderForCreatedAsset;
}

+ (PHObjectPlaceholder *)_placeholderImagePath:(NSURL *)path {
    PHAssetChangeRequest *createAssetRequest = [PHAssetChangeRequest creationRequestForAssetFromImageAtFileURL:path];
    return createAssetRequest.placeholderForCreatedAsset;
}
#pragma video
+ (void)mm_saveVideoAtPath:(NSURL *)url toAlbumWithName:(NSString *)albumName completion:(void(^)(PHFetchResult<PHAsset *> * _Nullable, NSError * _Nullable))completion {
    [self mm_requestAuthorizationWithCompletion:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            PHAssetCollection *album = [self mm_findAlbumWithName:albumName];
            [self _saveVideoAtPath:url toAlbum:album completion:completion];
        } else {
            NSError *error = [NSError errorWithDomain:@"com.album.authentication.mm"
                                                 code:-1
                                             userInfo:nil];
            completion ? completion(nil, error) : nil;
        }
    }];
}

+ (void)_saveVideoAtPath:(NSURL *)url toAlbum:(PHAssetCollection *)album completion:(void(^)(PHFetchResult<PHAsset *> * _Nullable, NSError * _Nullable))completion {
    __block PHObjectPlaceholder *placeholder = nil;
    
    [PHPhotoLibrary.sharedPhotoLibrary performChanges:^{
        if (album) {
            placeholder = [self _haveAlbumSaveVideo:url toAlbum:album];
        } else {
            placeholder = [self _noAlbumSaveVideo:url];
        }
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        [PHPhotoLibrary saveOneCompletion:completion success:success placeholder:placeholder error:error];
    }];
}

+ (void)saveOneCompletion:(void(^)(PHFetchResult<PHAsset *> * _Nullable, NSError * _Nullable))completion
                  success:(BOOL)success
              placeholder:(PHObjectPlaceholder *)placeholder
                    error:(NSError *)error {
    if (completion) {
        if (success && placeholder) {
            PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsWithLocalIdentifiers:@[placeholder.localIdentifier] options:nil];
            completion(assets, nil);
        } else {
            completion(nil, error);
        }
    }
}

+ (PHObjectPlaceholder *)_noAlbumSaveVideo:(NSURL *)url {
    PHAssetChangeRequest *createAssetRequest = [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:url];
    PHObjectPlaceholder *placeholder = createAssetRequest.placeholderForCreatedAsset;
    return placeholder;
}

+ (PHObjectPlaceholder *)_haveAlbumSaveVideo:(NSURL *)url toAlbum:(PHAssetCollection *)album {
    PHAssetChangeRequest *createAssetRequest = [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:url];
    PHAssetCollectionChangeRequest *albumChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:album];
    PHObjectPlaceholder *placeholder = createAssetRequest.placeholderForCreatedAsset;
    if (!placeholder) return nil;
    [albumChangeRequest addAssets:@[placeholder]];
    return placeholder;
}

+ (void)_openSettingAlert:(NSString *)title message:(NSString *)message {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"开启" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
        }];
        [alert addAction:cancel];
        [alert addAction:sure];
        UIViewController *topVC = [PHPhotoLibrary findTopVC:[UIApplication sharedApplication].delegate.window.rootViewController];
        if (topVC) {
            [topVC presentViewController:alert animated:YES completion:nil];
        }
        
    });
}

+ (UIViewController *)findTopVC:(UIViewController *)vc {
    UIViewController *currentShowingVC;
    if ([vc presentedViewController]) {
        UIViewController *nextRootVC = [vc presentedViewController];
        currentShowingVC = [self findTopVC:nextRootVC];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        UIViewController *nextRootVC = [(UITabBarController *)vc selectedViewController];
        currentShowingVC = [self findTopVC:nextRootVC];
 
    } else if ([vc isKindOfClass:[UINavigationController class]]){
        UIViewController *nextRootVC = [(UINavigationController *)vc visibleViewController];
        currentShowingVC = [self findTopVC:nextRootVC];
 
    } else {
        currentShowingVC = vc;
    }
    return currentShowingVC;
}


@end
