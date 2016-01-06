//
//  RatingView.m
//  DoubanWorlds
//
//  Created by LYoung on 16/1/5.
//  Copyright © 2016年 LYoung. All rights reserved.
//

#import "RatingView.h"

@interface RatingView ()

@end

@implementation RatingView


#define StarNormalColor KColor(229, 229, 229)//主题颜色
#define StarSelectedColor KColor(255, 183, 17)//主题颜色

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        //默认的星星的大小是 13.0f
        self.starSize = 13.0f;
        //未点亮时的颜色是 灰色的
        self.emptyColor = StarNormalColor;
        //点亮时的颜色是 亮黄色的
        self.fullColor = StarSelectedColor;
        //默认的长度设置为100
        self.maxStar = 100;
    }
    
    return self;
}

//重绘视图
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    NSString* stars = @"★★★★★";
    
    rect = self.bounds;
    UIFont *font = [UIFont boldSystemFontOfSize:_starSize];
    
    CGSize starSize = [stars sizeWithFont:font];

    rect.size=starSize;
    [_emptyColor set];

    [stars drawInRect:rect withFont:font];
    
    CGRect clip = rect;
    clip.size.width = clip.size.width * _showStar / _maxStar;
    CGContextClipToRect(context,clip);
    [_fullColor set];
    [stars drawInRect:rect withFont:font];
}
@end
