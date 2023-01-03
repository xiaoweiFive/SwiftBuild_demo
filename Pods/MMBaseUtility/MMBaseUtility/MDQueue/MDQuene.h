//
//  MDQuene.h
//  MomoChat
//
//  Created by yzkmac on 2019/12/12.
//  Copyright © 2019 wemomo.com. All rights reserved.
//
// TOOD: 未使用

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 非线程安全队列
@interface MDQuene : NSObject

@property (nonatomic, assign, readonly) BOOL isFull; //队列是否已满，maxCount为0时，队列永远不会满
@property (nonatomic, assign, readonly) BOOL isEmpty; //队列是否已空

/// 创建队列
/// @param maxCount 队列元素最大个数，0 表示不限制
- (instancetype)initWithMaxCount:(NSInteger)maxCount;

/// 插入队尾，返回是否成功入队(队列已满，入队失败)
/// @param object 入队元素
- (BOOL)append:(nonnull id)object;

/// 插入队首，返回是否成功入队(队列已满，入队失败)
/// @param object 入队元素
- (BOOL)insert:(nonnull id)object;

/// 更新插入元素，更新如果队列中不包含此元素，则插入队尾/队首。如果包含，调整到队尾/队首。
/// @param object 元素
- (BOOL)upsertToTail:(nonnull id)object;
- (BOOL)upsertToHead:(nonnull id)object;

/// 出队，返回出队元素
- (id)remove;

/// 清空队列
- (void)removeAll;

/// 是否包含元素
/// @param object 元素
- (BOOL)containsObject:(nonnull id)object;

@end

NS_ASSUME_NONNULL_END
