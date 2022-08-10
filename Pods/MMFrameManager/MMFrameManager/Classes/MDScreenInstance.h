//
//  MDScreenInstance.h
//  MomoChat
//
//  Created by litianpeng on 2020/4/8.
//  Copyright © 2020 wemomo.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MDScreenInstance : NSObject

@property (nonatomic, assign, readonly) CGFloat screenWidth;
@property (nonatomic, assign, readonly) CGFloat screenHeight;

+ (instancetype)shared;
- (void)updateFrame;

@end

NS_ASSUME_NONNULL_END
