//
//  MDStack.m
//  BindingX
//
//  Created by YZK on 2019/3/20.
//

#import "MDStack.h"

@interface MDStack ()
@property (nonatomic, strong) NSMutableArray *mArr;
@end

@implementation MDStack

- (instancetype)init {
    self = [super init];
    if (self) {
        self.mArr = [NSMutableArray array];
    }
    return self;
}

- (id)top {
    return self.mArr.lastObject;
}

- (void)pop {
    [self.mArr removeLastObject];
}

- (void)push:(id)element {
    if (!element) {//element为空时崩溃
        return;
    }
    [self.mArr addObject:element];
}

- (BOOL)isEmpty {
    return self.mArr.count == 0;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p>\n%@", NSStringFromClass([self class]), self, self.mArr];
}

@end
