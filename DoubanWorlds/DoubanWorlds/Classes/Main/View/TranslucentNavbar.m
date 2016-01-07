//
//  TranslucentNavbar.m
//  DoubanWorlds
//
//  Created by LYoung on 16/1/7.
//  Copyright © 2016年 LYoung. All rights reserved.
//

#import "TranslucentNavbar.h"

@interface TranslucentNavbar ()

{
    UIButton *_backButton;
    UIView *_lineView;
}

@end

@implementation TranslucentNavbar

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64);
        //2.返回按钮
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setBackgroundImage:[UIImage imageNamed:@"nav_arrow_white"] forState:UIControlStateNormal];
        [_backButton setBackgroundImage:[UIImage imageNamed:@"nav_arrow_white"] forState:UIControlStateHighlighted];
        _backButton.frame = CGRectMake(0, 20, 40, 44);
        [_backButton addTarget:self action:@selector(backBntClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_backButton];
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [AppTools colorWithHexString:@"#F0F0F0"];
        _lineView.frame = CGRectMake(0, 63, SCREEN_WIDTH, 1);
        [self addSubview:_lineView];
        
        _lineView.hidden = YES;
    }
    return self;
}



-(void)setBarHidden:(BOOL)barHidden{
    _barHidden = barHidden;
    if (barHidden) {
        _lineView.hidden = YES;
        [_backButton setBackgroundImage:[UIImage imageNamed:@"nav_arrow_white"] forState:UIControlStateNormal];
        [_backButton setBackgroundImage:[UIImage imageNamed:@"nav_arrow_white"] forState:UIControlStateHighlighted];
        [UIView animateWithDuration:0.3 animations:^{
            self.backgroundColor = [UIColor clearColor];
        }];
    }else{
        _lineView.hidden = NO;
        [_backButton setBackgroundImage:[UIImage imageNamed:@"nav_arrow"] forState:UIControlStateNormal];
        [_backButton setBackgroundImage:[UIImage imageNamed:@"nav_arrow"] forState:UIControlStateHighlighted];
        
        [UIView animateWithDuration:0.3 animations:^{
            self.backgroundColor = [AppTools colorWithHexString:@"f0f0f0"];
        }];

    }
}


-(void)backBntClicked{
    [self.viewController.navigationController popViewControllerAnimated:YES];
}

@end
