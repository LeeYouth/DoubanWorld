//
//  MainNavgationController.m
//  AnecdotesDemo
//
//  Created by LYoung on 15/10/13.
//  Copyright (c) 2015年 LYoung. All rights reserved.
//

#import "MainNavgationController.h"

@implementation MainNavgationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    UIImage *bgImage = nil;
//    if (iOS7) {
//        bgImage = [AppTools imageWithColor:TheThemeColor];
//    } else {
//        bgImage = [UIImage imageNamed:@"navBackgroundImg"];
//    }
//    bgImage = [bgImage stretchableImageWithLeftCapWidth:0.5 topCapHeight:0.5];
//    [self.navigationBar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
   
    self.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
    
}


#pragma mark 隐藏tabbar
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:YES];
}

@end
