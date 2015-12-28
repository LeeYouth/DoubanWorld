//
//  BaseViewController.m
//  DoubanWorlds
//
//  Created by LYoung on 15/12/28.
//  Copyright © 2015年 LYoung. All rights reserved.
//

#import "BaseViewController.h"
#import "UIBarButtonItem+Extension.h"

@interface BaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //不设置此处会导致View上移
    if(iOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    [self creatLeftBtn];
}
-(void)creatLeftBtn{
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    UIBarButtonItem *buttonItem = [UIBarButtonItem itemWithImage:@"nav_arrow" higlightedImage:@"nav_arrow" target:self action:@selector(superArrowButtonClick)];
        
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -20;
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, buttonItem];

    
//    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(superArrowButtonClick) normalImage:@"nav_arrow" highlightedImage:@"nav_arrow"];
}

- (void)superArrowButtonClick{
    
    if ([self.navigationController respondsToSelector:@selector(popViewControllerAnimated:)]){
        [self.navigationController popViewControllerAnimated:YES];
    }
    if([self respondsToSelector:@selector(dismissModalViewControllerAnimated:)]){
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}



@end
