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
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(superArrowButtonClick) normalImage:@"stock_navtitle_leftback" highlightedImage:@"stock_navtitle_leftback"];
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
