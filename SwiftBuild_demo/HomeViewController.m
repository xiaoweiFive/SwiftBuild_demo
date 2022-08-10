//
//  HomeViewController.m
//  SwiftBuild_demo
//
//  Created by zhangzhenwei on 2022/7/14.
//

#import "HomeViewController.h"
#import "SwiftBuild_demo-Swift.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];

    [self presentViewController:[[TestHomeViewController alloc] init] animated:true completion:nil];
}


@end
