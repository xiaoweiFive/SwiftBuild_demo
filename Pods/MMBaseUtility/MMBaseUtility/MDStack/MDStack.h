//
//  MDStack.h
//  BindingX
//
//  Created by YZK on 2019/3/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MDStack : NSObject

- (id)top;
- (void)pop;
- (void)push:(id)element;
- (BOOL)isEmpty;

@end

NS_ASSUME_NONNULL_END
