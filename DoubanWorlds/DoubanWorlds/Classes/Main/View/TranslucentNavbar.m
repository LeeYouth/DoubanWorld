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
    UILabel *_titleLabel;
    UILabel *_orgLabel;//副标题

}

@end

@implementation TranslucentNavbar

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64);
        //1.返回按钮
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setBackgroundImage:[UIImage imageNamed:@"nav_arrow_white"] forState:UIControlStateNormal];
        [_backButton setBackgroundImage:[UIImage imageNamed:@"nav_arrow_white"] forState:UIControlStateHighlighted];
        _backButton.frame = CGRectMake(0, 20, 40, 44);
        [_backButton addTarget:self action:@selector(backBntClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_backButton];
        
        //2.线
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [AppTools colorWithHexString:@"#F0F0F0"];
        _lineView.frame = CGRectMake(0, 63, SCREEN_WIDTH, 1);
        [self addSubview:_lineView];
        
        _lineView.hidden = YES;
        
        //3.标题
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:16.0];
        _titleLabel.frame = CGRectMake(SCREEN_WIDTH/2 - 100, 20, 200, 20);
        [self addSubview:_titleLabel];
        
        _titleLabel.hidden = YES;
        
        //3.副标题
        _orgLabel = [[UILabel alloc] init];
        _orgLabel.backgroundColor = [UIColor clearColor];
        _orgLabel.textAlignment = NSTextAlignmentCenter;
        _orgLabel.textColor = [UIColor lightGrayColor];
        _orgLabel.font = [UIFont systemFontOfSize:13.0];
        _orgLabel.frame = CGRectMake(SCREEN_WIDTH/2 - 100, 42, 200, 20);
        [self addSubview:_orgLabel];
        
        _titleLabel.hidden = YES;
        _orgLabel.hidden = YES;
        
        
    }
    return self;
}



-(void)setBarHidden:(BOOL)barHidden{
    _barHidden = barHidden;
    if (barHidden) {
        _lineView.hidden = YES;
        _titleLabel.hidden = YES;
        _orgLabel.hidden = YES;
        [_backButton setBackgroundImage:[UIImage imageNamed:@"nav_arrow_white"] forState:UIControlStateNormal];
        [_backButton setBackgroundImage:[UIImage imageNamed:@"nav_arrow_white"] forState:UIControlStateHighlighted];
        [UIView animateWithDuration:0.3 animations:^{
            self.backgroundColor = [UIColor clearColor];
        }];
    }else{
        
        [_backButton setBackgroundImage:[UIImage imageNamed:@"nav_arrow"] forState:UIControlStateNormal];
        [_backButton setBackgroundImage:[UIImage imageNamed:@"nav_arrow"] forState:UIControlStateHighlighted];
        [UIView animateWithDuration:0.3 animations:^{
            self.backgroundColor = [AppTools colorWithHexString:@"f0f0f0"];
        }];
        
        _lineView.hidden = YES;
        _titleLabel.hidden = NO;
        _orgLabel.hidden = NO;
    }
}
-(void)setTitle:(NSString *)title{
    _title = title;
    _titleLabel.text = title;
    
}

-(void)setOrgTitle:(NSString *)orgTitle{
    _orgTitle = orgTitle;
    _orgLabel.text = orgTitle;
}

-(void)backBntClicked{
    [self.viewController.navigationController popViewControllerAnimated:YES];
}

@end
