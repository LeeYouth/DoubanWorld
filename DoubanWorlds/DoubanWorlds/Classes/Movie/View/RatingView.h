//
//  RatingView.h
//  DoubanWorlds
//
//  Created by LYoung on 16/1/5.
//  Copyright © 2016年 LYoung. All rights reserved.
//  星级评价视图

#import <UIKit/UIKit.h>

@interface RatingView : UIView

@property (nonatomic, assign) CGFloat starSize;
@property (nonatomic, assign) float maxStar;
@property (nonatomic, assign) float showStar;
@property (nonatomic, retain) UIColor *emptyColor;
@property (nonatomic, retain) UIColor *fullColor;

@end
