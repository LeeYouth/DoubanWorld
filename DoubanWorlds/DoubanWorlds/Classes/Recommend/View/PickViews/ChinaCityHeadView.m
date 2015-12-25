//
//  ChinaCityHeadView.m
//  DoubanWorlds
//
//  Created by LYoung on 15/12/25.
//  Copyright © 2015年 LYoung. All rights reserved.
//

#import "ChinaCityHeadView.h"
#import "SKTagView.h"

#define IntroFont 14.f

@interface ChinaCityHeadView ()
{
    UILabel *_currentLabel;//当前城市
    UILabel *_hotLabel;//热门城市
    
}

@property (nonatomic, strong) SKTagView *tagView;
@property (nonatomic, strong) NSArray *colorPool;


@end

@implementation ChinaCityHeadView


-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = KColor(235, 235, 241);

        self.colorPool = @[@"#7ecef4", @"#84ccc9", @"#88abda",@"#7dc1dd",@"#b6b8de"];

        
        [self initUI];
        

        [self setupLayOut];
        
    }
    return self;
}



-(void)initUI{
    _currentLabel = [[UILabel alloc] init];
    _currentLabel.backgroundColor = [UIColor clearColor];
    _currentLabel.font = [UIFont systemFontOfSize:IntroFont];
    _currentLabel.textColor = [UIColor grayColor];
    _currentLabel.text = @"当前城市";
    [self addSubview:_currentLabel];
    
    _hotLabel = [[UILabel alloc] init];
    _hotLabel.backgroundColor = [UIColor clearColor];
    _hotLabel.font = [UIFont systemFontOfSize:IntroFont];
    _hotLabel.textColor = [UIColor grayColor];
    _hotLabel.text = @"热门城市";
    [self addSubview:_hotLabel];
}

-(void)setupLayOut{
    int margin = 10;
    int padding = 15;
    
    [_currentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(margin);
        make.left.equalTo(self).offset(padding);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
//    [_currentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self).offset(margin);
//        make.left.equalTo(self).offset(padding);
//        make.size.mas_equalTo(CGSizeMake(100, 20));
//    }];
}

@end
