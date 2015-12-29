//
//  YLYSearchBar.m
//  VSina
//
//  Created by 苑立永 on 14-9-20.
//  Copyright (c) 2014年 苑立永. All rights reserved.
//

#import "YLYSearchBar.h"
//#import "UIImage+Extension.h"

@implementation YLYSearchBar
/**
 *  init方法内部会调用这个方法
 */
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
//        self.background = [UIImage resizedImage:@"searchbar_textfield_background"];
        self.textAlignment = NSTextAlignmentLeft;
        self.placeholder = @"输入城市名查询";
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        //设置放大镜图片
        //设置左边的图片永远显示
        self.leftViewMode = UITextFieldViewModeAlways;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        imageView.frame = CGRectMake(0, 0, 30, 30);
        imageView.contentMode = UIViewContentModeCenter;
        self.leftView = imageView;
        
        self.font = [UIFont systemFontOfSize:15.0f];
    }
    return self;
}


@end
