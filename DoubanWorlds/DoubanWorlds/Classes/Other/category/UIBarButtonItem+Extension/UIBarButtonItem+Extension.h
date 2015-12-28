//
//  UIBarButtonItem+Extension.h
//  Finance
//
//  Created by xinbb on 15/7/13.
//  Copyright (c) 2015年 LYoung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action normalImage:(NSString *)normalImage highlightedImage:(NSString *)highlightedImage;

+(UIBarButtonItem *)itemWithImage:(NSString *)image higlightedImage:(NSString *)hilight target:(id)target action:(SEL)action;

@end
