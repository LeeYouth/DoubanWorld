//
//  SectionHeaderView.h
//  DoubanWorlds
//
//  Created by LYoung on 15/12/23.
//  Copyright © 2015年 LYoung. All rights reserved.
//  城市选择器头部视图

#import <UIKit/UIKit.h>

@interface SectionHeaderView : UIView


@property (nonatomic, copy) NSString *text;

+(CGFloat)getSectionHeadHeight;

@end
