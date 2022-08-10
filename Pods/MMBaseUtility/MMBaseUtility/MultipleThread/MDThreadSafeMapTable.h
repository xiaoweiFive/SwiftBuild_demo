//
//  MDThreadSafeMapTable.h
//  MomoChat
//
//  Created by Dai Dongpeng on 2018/8/21.
//  Copyright © 2018年 wemomo.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDThreadSafeMapTable <KeyType, ObjectType> : NSObject

+ (MDThreadSafeMapTable<KeyType, ObjectType> *)mapTableWithKeyOptions:(NSPointerFunctionsOptions)keyOptions valueOptions:(NSPointerFunctionsOptions)valueOptions;

@property (nonatomic, assign, readonly) NSUInteger count;

- (ObjectType)objectForKey:(KeyType)aKey;
- (void)removeObjectForKey:(KeyType)aKey;
- (void)setObject:(ObjectType)anObject forKey:(KeyType)aKey;   // add/replace value (CFDictionarySetValue, NSMapInsert)
- (void)removeAllObjects;

@end
