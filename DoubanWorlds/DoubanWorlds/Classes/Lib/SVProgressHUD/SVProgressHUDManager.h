//
//  SVProgressHUDManager.h
//  Finance
//
//  Created by LYoung on 15/9/2.
//  Copyright (c) 2015年 LYoung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVProgressHUD.h"

@interface SVProgressHUDManager : NSObject


/** 单例 */
+ (id)defaultManager;

/**
 *  失败显示HUD
 *
 *  @param status 失败描述
 */
+ (void)showErrorWithStatus:(NSString *)status;
/**
 *  成功显示HUD
 *
 *  @param status 成功描述
 */
+ (void)showSuccessWithStatus:(NSString *)status;

/**
 *  提示显示HUD
 *
 *  @param status 提示描述
 */
+ (void)showInfoWithStatus:(NSString *)status;

/**
 *  带提示的菊花显示
 *
 *  @param status 提示
 */
+ (void)showWithStatus:(NSString *)status;

/**
 *  带提示的菊花显示(不可点击)
 *
 *  @param status 提示
 */
+ (void)showWithStatusClearType:(NSString *)status;


/**
 *  HUD视图出现(没有文字提示的菊花)
 */
+ (void)show;

/**
 *  HUD视图出现(没有文字提示的菊花)不可点击
 */
+ (void)showClearType;


/**
 *  网络错误提示
 */
+(void)networkError;











/**
 *  HUD视图消失
 */
+ (void)dismiss;




@end
