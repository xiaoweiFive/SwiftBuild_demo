//
//  MDLinkedMap.m
//  MomoChat
//
//  Created by Eli xu on 16/4/16.
//  Copyright © 2016年 wemomo.com. All rights reserved.
//

#import "MDLinkedMap.h"

@implementation MDLinkedNode
{
    @package
    __weak MDLinkedNode *_pre;
    __weak MDLinkedNode *_next;
}

@end

@implementation MDLinkedMap
{
    @package
    CFMutableDictionaryRef _dic;
    MDLinkedNode *_head;
    MDLinkedNode *_tail;
    NSUInteger _count;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dic = CFDictionaryCreateMutable(CFAllocatorGetDefault(), 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    }
    return self;
}

- (void)dealloc
{
    CFRelease(_dic);
}

- (void)insertHeadNode:(MDLinkedNode *)node
{
    if (!node.key) {
        return;
    }//node的key不能为空，为空报错
    CFDictionarySetValue(_dic, (__bridge const void *)(node.key), (__bridge const void *)(node));
    _count++;
    if (_head) {
        node->_next = _head;
        _head->_pre = node;
        _head = node;
    } else {
        _head = _tail = node;
    }
}

- (void)addTailNode:(MDLinkedNode *)node
{
    CFDictionarySetValue(_dic, (__bridge const void *)(node.key), (__bridge const void *)(node));
    _count++;
    if (_tail) {
        node->_pre = _tail;
        _tail->_next = node;
        _tail = node;
        
    } else {
        _tail = _head = node;
    }
}

- (void)bringNodeToHead:(MDLinkedNode *)node
{
    if (![self nodeForKey:node.key]) {
        return;
    }//如果node不在linkMap中，却直接使用bringNodeToHead方法，直接崩溃
    if (_head == node) {
        return;
    }
    if (_tail == node) {
        _tail = node->_pre;
        _tail->_next = nil;
    } else {
        node->_next->_pre = node->_pre;
        node->_pre->_next = node->_next;
    }
    node->_next = _head;
    node->_pre = nil;
    _head->_pre = node;
    _head = node;
}

- (MDLinkedNode *)nodeAtIndex:(NSUInteger)index
{
    if (_count == 0 || (index > (_count-1))) {
        return nil;
    }
    if (index == _count) {
        return _tail;
    }
    if (index == 0) {
        return _head;
    }
    
    int i = 1;
    MDLinkedNode *node = _head ->_next;
    while (i != index) {
        i++;
        if (node) {
            node = node->_next;
        }
    }
    return node;
}

- (id)nodeForKey:(id)key
{
    if (!key) {
        return nil;
    }
    MDLinkedNode *node = CFDictionaryGetValue(_dic, (__bridge const void *)(key));
    return node;
}

- (void)setObjectOfNode:(id)obj ForKey:(id)key
{
    MDLinkedNode *node = [self nodeForKey:key];
    if (node) {
        node.obj = obj;
        [self bringNodeToHead:node];
    } else {
        node = [MDLinkedNode new];
        node.key = key;
        node.obj = obj;
        [self insertHeadNode:node];
    }
}

- (void)updateObjectOfNode:(id)obj ForKey:(id)key
{
    // 只更新节点
    MDLinkedNode *node = [self nodeForKey:key];
    if (node){
        node.obj = obj;
    }
}

- (void)appendObjectOfNode:(id)obj ForKey:(id)key
{
    if (!obj || !key) return;
    if ([self nodeForKey:key]) return;
    MDLinkedNode *node = [MDLinkedNode new];
    node.key = key;
    node.obj = obj;
    [self addTailNode:node];
}

- (id)objectOfNodeAtIndex:(NSUInteger)index
{
    MDLinkedNode *anode = [self nodeAtIndex:index];
    return anode ? anode.obj : nil;
}

- (id)objectOfNodeForKey:(id)key
{
    MDLinkedNode *anode = [self nodeForKey:key];
    return anode ? anode.obj : nil;
}

- (BOOL)removeNodeForKey:(id)key
{
    MDLinkedNode *anode = [self nodeForKey:key];
    BOOL success = NO;
    if (anode) {
        [self removeNode:anode];
        success = YES;
    }
    return success;
}

- (void)removeNode:(MDLinkedNode *)node
{
    CFDictionaryRemoveValue(_dic, (__bridge const void *)(node.key));
    _count--;
    if (node->_next) {
        node->_next->_pre = node->_pre;
    }
    if (node->_pre) {
        node->_pre->_next = node->_next;
    }
    if (_head == node) {
        _head = node->_next;
    }
    if (_tail == node) {
        _tail = node->_pre;
    }
}

- (void)removeAllNode
{
    _count = 0;
    _head = nil;
    _tail = nil;
    if (CFDictionaryGetCount(_dic) > 0) {
        CFMutableDictionaryRef holder = _dic;
        _dic = CFDictionaryCreateMutable(CFAllocatorGetDefault(), 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
        CFRelease(holder);
    }
}

- (NSUInteger)nodeCount
{
    return MAX(_count, 0);
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", _dic];
}

@end
