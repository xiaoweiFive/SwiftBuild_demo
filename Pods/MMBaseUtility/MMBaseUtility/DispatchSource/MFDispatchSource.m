//
//  MFDispatchSource.m
//  MomoChat
//
//  Created by xu bing on 13-6-7.
//  Copyright (c) 2013年 wemomo.com. All rights reserved.
//

#import "MFDispatchSource.h"

#define refreshMaxCount             1

@interface MFDispatchSource()
@property (atomic, strong) dispatch_source_t source;
@property (atomic, strong) dispatch_queue_t  dataQueue;
@end

@implementation MFDispatchSource

+ (instancetype)sourceWithDelegate:(id)aDelegate type:(refreshType)refreshType dataQueue:(dispatch_queue_t)queue
{
    return [[MFDispatchSource alloc] initWithDelegate:aDelegate type:refreshType dataQueue:queue];
}

- (instancetype)initWithDelegate:(id)aDelegate type:(refreshType)refreshType dataQueue:(dispatch_queue_t)queue
{
    self = [super init];
    if (self) {
        _delegate = aDelegate;
        _dataQueue = queue;
        [self createSourceByType:refreshType];
    }
    return self;
}

- (void)createSourceByType:(refreshType)type
{
    __weak __typeof(self) weakSelf = self;
    switch (type) {
        case refreshType_UI:
        {
            self.source = dispatch_source_create(DISPATCH_SOURCE_TYPE_DATA_ADD, 0, 0, dispatch_get_main_queue());//由于此类用于用户事件对数据的频繁更新从而对UI的更新操作要在mainQueue上
            dispatch_source_set_event_handler(self.source, ^{
                if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(refreshUI)]) {
                    [weakSelf.delegate refreshUI];
                }
            });
            dispatch_resume(self.source);
        }
            break;
        case refreshType_Data:
        {
            self.source = dispatch_source_create(DISPATCH_SOURCE_TYPE_DATA_ADD, 0, 0, _dataQueue);//更新数据相关的操作方放到低级子线程
            dispatch_source_set_event_handler(self.source, ^{
                if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(refreshData)]) {
                    [weakSelf.delegate refreshData];
                }
            });
            dispatch_resume(self.source);
        }
            break;
        case refreshType_None:
        {
            self.source = dispatch_source_create(DISPATCH_SOURCE_TYPE_DATA_ADD, 0, 0, dispatch_get_main_queue());//默认更新UI
            dispatch_source_set_event_handler(self.source, ^{
                if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(refreshUI)]) {
                    [weakSelf.delegate refreshUI];
                }
            });
            dispatch_resume(self.source);
        }
            break;
        default:
            break;
    }
}

- (void)addSemaphore
{
    //发出source 更新信号一次
    dispatch_apply(refreshMaxCount, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t index){
        if (self.source) {
            dispatch_source_merge_data(self.source, 1);
        }
    });
}

- (void)clearDelegateAndCancel
{
    _delegate = nil;
    if (self.source) {
        dispatch_source_cancel(self.source);
        self.source = nil;
    }
}

- (void)dealloc
{
    [self clearDelegateAndCancel];
    _delegate = nil;
    _dataQueue = nil;
}

@end
