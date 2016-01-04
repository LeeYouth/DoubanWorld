//
//  RecommendHeadView.m
//  DoubanWorlds
//
//  Created by LYoung on 16/1/4.
//  Copyright © 2016年 LYoung. All rights reserved.
//

#import "RecommendHeadView.h"
#import "PickCityViewController.h"

@interface RecommendHeadView()
{
    UILabel *_currentCity;
}

@end

@implementation RecommendHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        //height = 70
        self.backgroundColor = KBackgroundColor;
        
        
        [self initUI];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityButtonClick:) name:kCityButtonClick object:nil];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [self addGestureRecognizer:tap];

    }
    return self;
}

-(void)tapAction{
    PickCityViewController *pickVC = [[PickCityViewController alloc] init];
    [self.viewController.navigationController pushViewController:pickVC animated:YES];
}


-(void)initUI{
    
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backView];
    
    UILabel *currentL = [[UILabel alloc] init];
    currentL.text = @"当前城市: ";
    currentL.backgroundColor = [UIColor clearColor];
    currentL.font = [UIFont systemFontOfSize:16.f];
    currentL.textColor = [UIColor lightGrayColor];
    [backView addSubview:currentL];
    
    _currentCity = [[UILabel alloc] init];
    _currentCity.text = @"北京";
    _currentCity.backgroundColor = [UIColor clearColor];
    _currentCity.font = [UIFont systemFontOfSize:16.f];
    _currentCity.textColor = TheThemeColor;
    [backView addSubview:_currentCity];
    
    int padding = 15;
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.with.width.equalTo(self);
        make.top.equalTo(self).offset(padding);
        make.height.mas_equalTo(@40);
    }];
    
    [currentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_left).offset(padding);
        make.top.mas_equalTo(@10);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    
    [_currentCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(currentL.mas_right);
        make.top.equalTo(currentL.mas_top);
        make.size.mas_equalTo(CGSizeMake(120, 20));
    }];
    
    
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:kIsCityButtonClick]) {//是否点击选择了城市
        NSString *cName = [[NSUserDefaults standardUserDefaults] objectForKey:kCityButtonClick];
        _currentCity.text = cName;
        
    }else{
        NSString *defaultsName = [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentLocation];
        
        if ([NSString checkConvertNull:defaultsName])//第一次登录
        {
            _currentCity.text = @"北京";
        }else
        {
            NSString *defaultsName = [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentLocation];
            _currentCity.text = defaultsName;

        }
    }
}

#pragma mark - 城市按钮点击
- (void)cityButtonClick:(NSNotification *)note{
    NSString *cname = note.userInfo[kCityButtonClick];
    
    if (cname) {
        
        _currentCity.text = cname;
        
        [[NSUserDefaults standardUserDefaults] setValue:cname forKey:kCityButtonClick];
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kIsCityButtonClick];
    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



@end
