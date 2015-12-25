//
//  ChinaCityHeadView.m
//  DoubanWorlds
//
//  Created by LYoung on 15/12/25.
//  Copyright © 2015年 LYoung. All rights reserved.
//

#import "ChinaCityHeadView.h"

@interface ChinaCityHeadView ()
{
    UILabel *_currentLabel;//当前城市
    UILabel *_hotLabel;//热门城市
    
}

@end

@implementation ChinaCityHeadView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = KColor(235, 235, 241);

        
        
        [self initUI];
        
        
        
    }
    return self;
}

-(void)initUI{
    _currentLabel = [[UILabel alloc] init];
    _currentLabel.backgroundColor = [UIColor redColor];
    _currentLabel.text = @"当前城市";
    [self addSubview:_currentLabel];
    
    _hotLabel = [[UILabel alloc] init];
    _hotLabel.backgroundColor = [UIColor redColor];
    _hotLabel.text = @"热门城市";
    [self addSubview:_hotLabel];
}

@end
