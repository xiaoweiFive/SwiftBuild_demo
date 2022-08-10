//
//  MDLinkedMap.h
//  MomoChat
//
//  Created by Eli xu on 16/4/16.
//  Copyright © 2016年 wemomo.com. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 ************* NOT THEAD SAFE *************
 just for Messager
 */

/// 链表加字典的组合。可以理解为有顺序的字典。
@interface MDLinkedNode : NSObject

@property (nonatomic, strong) id key;
@property (nonatomic, strong) id obj;

@end

@interface MDLinkedMap : NSObject

- (void)insertHeadNode:(MDLinkedNode *)node;
- (void)addTailNode:(MDLinkedNode *)node;
- (void)bringNodeToHead:(MDLinkedNode *)node;
- (id)objectOfNodeAtIndex:(NSUInteger)index;
- (id)objectOfNodeForKey:(id)key;
- (void)setObjectOfNode:(id)obj ForKey:(id)key;
- (void)updateObjectOfNode:(id)obj ForKey:(id)key;
- (BOOL)removeNodeForKey:(id)key;
- (void)removeNode:(MDLinkedNode *)node;
- (void)appendObjectOfNode:(id)obj ForKey:(id)key;
- (void)removeAllNode;
- (NSUInteger)nodeCount;

@end
