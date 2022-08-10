//
//  MDLockDefinitions.h
//  MMFoundation
//
//  Created by Dai Dongpeng on 2017/11/2.
//  Copyright © 2017年 momo783. All rights reserved.
//

#ifndef MDLockDefinitions_h
#define MDLockDefinitions_h

#import <pthread.h>

// 需要预先定义一个实例变量 pthread_mutex_t _lock;
#define Mutex_LockInit() pthread_mutex_init(&(_lock), NULL)
#define Mutex_Lock() pthread_mutex_lock(&(_lock))
#define Mutex_UnLock() pthread_mutex_unlock(&(_lock))
#define Mutex_LockDestroy() pthread_mutex_destroy(&(_lock))

#endif /* MDLockDefinitions_h */
