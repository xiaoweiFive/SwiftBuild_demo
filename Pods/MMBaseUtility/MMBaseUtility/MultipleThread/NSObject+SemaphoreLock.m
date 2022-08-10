//
//  NSObject+SemaphoreLock.m
//  MomoChat
//
//  Created by song.meng on 2021/6/16.
//  Copyright © 2021 wemomo.com. All rights reserved.
//

#import "NSObject+SemaphoreLock.h"
#import <objc/runtime.h>

#if defined(DEBUG) || defined(INHOUSE)
#import <UIKit/UIKit.h>
#endif

NSString *const MMNSObjectThreadBlockedNotification = @"MMNSObjectThreadBlockedNotification";

#define ThreadMayBeBlockSeconds 5
/// 一个锁等待5秒则认为超时，当前线程可能已死锁
#define ThreadMayBeBlockTime  dispatch_time(DISPATCH_TIME_NOW, ThreadMayBeBlockSeconds * NSEC_PER_SEC)

@implementation NSObject (SemaphoreLock)
static const char *MMNSObjectSemaphoreLockAssociatedKey;
static const char *MMNSObjectIdentifireAssociatedKey;

- (void)initSemaphoreLock {
    [self mm_threadSafeSemaphoreLock];
}

- (void)initSemaphoreLockWithIdentifire:(NSString *)identfire {
    [self mm_threadSafeSemaphoreLock];
    
    if (![identfire isKindOfClass:[NSString class]] || identfire.length == 0) {
        NSAssert(NO, @"【NSObject+SemaphoreLock ERROR】identifire should be a meaningful string");
    }
    [self mm_setThreadIdentifire:identfire];
}

- (void)threadSafeSyncAction:(dispatch_block_t)action {
    if (!action) {
        return;
    }
    
    dispatch_semaphore_t lock = [self mm_threadSafeSemaphoreLock];
    intptr_t result = dispatch_semaphore_wait(lock, ThreadMayBeBlockTime);
    
//    NSAssert(result == 0, @"【 ERROR 】semaphore lock timeout, thread may be blocked !!!!");
    
    if (result == 0) {
        action();
        dispatch_semaphore_signal(lock);
    } else {
        NSLog(@"【NSObject+SemaphoreLock ERROR】semaphore lock timeout !!!!");
        [NSObject mm_showThreadBlockWarning:self timeOutInterval:ThreadMayBeBlockSeconds];
    }
}

- (intptr_t)threadSafeSyncAction:(dispatch_block_t)action timeOut:(NSTimeInterval)interval {
    if (!action) {
        return 0;
    }
    
    dispatch_semaphore_t lock = [self mm_threadSafeSemaphoreLock];
    intptr_t result = dispatch_semaphore_wait(lock, dispatch_time(DISPATCH_TIME_NOW, interval * NSEC_PER_SEC));
    
    if (result == 0) {
        action();
        dispatch_semaphore_signal(lock);    // 获取锁后才解锁
    } else {
        NSLog(@"【NSObject+SemaphoreLock WARNING】semaphore lock timeout !!!!");
        // 等待超过默认阈值则弹窗提示
        if (interval >= ThreadMayBeBlockSeconds) {
            [NSObject mm_showThreadBlockWarning:self timeOutInterval:interval];
        }
    }
    
    // result为0表示正常获得锁，否则为timeout
    return result;
}

- (dispatch_semaphore_t)mm_threadSafeSemaphoreLock {
    dispatch_semaphore_t lock = objc_getAssociatedObject(self, &MMNSObjectSemaphoreLockAssociatedKey);
    if (!lock) {
        lock = dispatch_semaphore_create(1);
        [self mm_setThreadSafeSemaphoreLock:lock];
    }
    return lock;
}

- (void)mm_setThreadSafeSemaphoreLock:(dispatch_semaphore_t)threadSafe_lcok {
    objc_setAssociatedObject(self, &MMNSObjectSemaphoreLockAssociatedKey, threadSafe_lcok, OBJC_ASSOCIATION_RETAIN);
}

- (nullable NSString *)mm_threadIdentifire {
    return objc_getAssociatedObject(self, &MMNSObjectIdentifireAssociatedKey);
}

- (void)mm_setThreadIdentifire:(NSString *)identifire {
    objc_setAssociatedObject(self, &MMNSObjectIdentifireAssociatedKey, identifire, OBJC_ASSOCIATION_COPY);
}


/// blocked警告提示
+ (void)mm_showThreadBlockWarning:(id)object timeOutInterval:(NSTimeInterval)interval {
    NSString *identifire = [self mm_threadIdentifire];
    if ([identifire isKindOfClass:[NSString class]] && identifire.length) {
        object = [NSString stringWithFormat:@"identidire is: %@", identifire];
    }
    
    BOOL isMainThread = [NSThread isMainThread];

    NSString *msg = [NSString stringWithFormat:@"该对象信号量互斥操作存在死锁风险:%@ \n 等待超过时间：%.2f秒", object, interval];
    
    dispatch_block_t block = ^{
#if defined(DEBUG) || defined(INHOUSE)
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"警告" message:msg preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:nil]];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
#endif
        
        NSMutableDictionary *info = [NSMutableDictionary dictionary];
        if (object) {
            [info setValue:msg forKey:@"message"];
            [info setValue:@(interval) forKey:@"block_time"];
            [info setValue:NSStringFromClass(self) forKey:@"happen_class"];
            [info setValue:@(isMainThread) forKey:@"is_main_thread"];
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:MMNSObjectThreadBlockedNotification object:info];
    };
    
#if defined(DEBUG) || defined(INHOUSE)
    dispatch_async(dispatch_get_main_queue(), block);
#else
    block();
#endif
}


@end
