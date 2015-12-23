//
//  SVProgressHUDManager.m
//  Finance
//
//  Created by LYoung on 15/9/2.
//  Copyright (c) 2015年 LYoung. All rights reserved.
//

#import "SVProgressHUDManager.h"

static SVProgressHUDManager *svProgressHUDManager = nil;
@implementation SVProgressHUDManager

+ (id)defaultManager
{
    @synchronized(self){
        static dispatch_once_t pred;
        dispatch_once(&pred, ^{
            svProgressHUDManager = [[self alloc] init];
        });
    }
    return svProgressHUDManager;
}

#pragma mark - 失败显示HUD
+ (void)showErrorWithStatus:(NSString *)status
{
    [self setDefultProgressInfo];
    [SVProgressHUD showErrorWithStatus:status];
}

#pragma mark - 成功显示HUD
+ (void)showSuccessWithStatus:(NSString *)status
{
    [self setDefultProgressInfo];
    [SVProgressHUD showSuccessWithStatus:status];
}

#pragma mark - 提示显示HUD
+ (void)showInfoWithStatus:(NSString *)status
{
    [self setDefultProgressInfo];
    [SVProgressHUD showInfoWithStatus:status];
}

#pragma mark - 带提示的菊花显示
+ (void)showWithStatus:(NSString *)status
{
    [self setDefultProgressInfo];
    [SVProgressHUD showWithStatus:status];
}

#pragma mark - 带提示的菊花显示(不可点击)
+ (void)showWithStatusClearType:(NSString *)status
{
    [self setSVProgressHUDMaskClearType];
    [SVProgressHUD showWithStatus:status];
}


+(void)networkError
{
    [self showErrorWithStatus:@"网络开小差啦"];
}












#pragma mark - HUD视图消失
+ (void)dismiss
{
    [SVProgressHUD dismiss];
}

#pragma mark - HUD视图出现(没有文字提示的菊花)
+ (void)show
{
    [self setDefultProgressInfo];
    [SVProgressHUD show];
}

#pragma mark - 不可点击show
+(void)showClearType
{
    [self setSVProgressHUDMaskClearType];
    [SVProgressHUD show];
}

#pragma mark - 设置默认Progress
+(void)setDefultProgressInfo
{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
}

#pragma mark - SVProgressHUDMaskType(不可点击)
+(void)setSVProgressHUDMaskClearType
{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
}



@end
