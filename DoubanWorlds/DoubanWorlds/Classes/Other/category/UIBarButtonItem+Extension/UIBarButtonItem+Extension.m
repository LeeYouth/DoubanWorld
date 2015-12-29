//
//  UIBarButtonItem+Extension.h
//  Finance
//
//  Created by xinbb on 15/7/13.
//  Copyright (c) 2015年 LYoung. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)
/**
 *  创建一个item
 *
 *  @param target    点击item后调用哪个对象的方法
 *  @param action    点击item后调用target的哪个方法
 *  @param normalImage     图片
 *  @param highlightedImage 高亮的图片
 *
 *  @return 创建完的item
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action normalImage:(NSString *)normalImage highlightedImage:(NSString *)highlightedImage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    [btn setBackgroundImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    // 设置尺寸
    btn.size = btn.currentBackgroundImage.size;

    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+(UIBarButtonItem *)itemWithImage:(NSString *)image higlightedImage:(NSString *)hilight target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 30, 30);
    UIImage *normal  = [UIImage imageNamed:image];
    [btn setBackgroundImage:normal forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:hilight]forState:UIControlStateHighlighted];
    btn.bounds = CGRectMake(0, 0, normal.size.width, normal.size.height);
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+(UIBarButtonItem *)itemWithImage:(NSString *)image title:(NSString *)title target:(id)target action:(SEL)action
{
    //定位到的城市
//    _locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_locationBtn setTitle:@"北京" forState:UIControlStateNormal];
//    [_locationBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//    [_locationBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
//    [_locationBtn setImage:[UIImage imageNamed:@"LuckyMoney_ChangeArrow"] forState:UIControlStateNormal];
//    [_locationBtn addTarget:self action:@selector(pushPickViewController) forControlEvents:UIControlEventTouchUpInside];
//    _locationBtn.frame = CGRectMake(0, 0, 80, 40);
//    [_locationBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 60, 0, 0)];
//    [_locationBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateHighlighted];
    [btn setTitle:title forState:UIControlStateNormal];

    // 设置尺寸
    CGFloat w = 70;
    CGFloat h = 30;
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 50, 0, 0)];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
    

    btn.frame = CGRectMake(0, 0, w, h);
    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(0, 0, 30, 30);
//    UIImage *normal  = [UIImage imageNamed:image];
//    [btn setBackgroundImage:normal forState:UIControlStateNormal];
//    [btn setBackgroundImage:[UIImage imageNamed:hilight]forState:UIControlStateHighlighted];
//    btn.bounds = CGRectMake(0, 0, normal.size.width, normal.size.height);
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end
