//
//  MDThreadSafeDictionary.h
//  MomoChat
//
//  Created by xu bing on 16/3/8.
//  Copyright © 2016年 wemomo.com. All rights reserved.
//
// TODO: 同步磁盘有死锁风险，建议下线

#import <Foundation/Foundation.h>
/*
 pthread_mutex_t保证线程安全
 */
@interface MDThreadSafeDictionary<KeyType, ObjectType> : NSMutableDictionary<KeyType, ObjectType>

@end
