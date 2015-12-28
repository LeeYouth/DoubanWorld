//
//  HotCityCell.m
//  DoubanWorlds
//
//  Created by LYoung on 15/12/28.
//  Copyright © 2015年 LYoung. All rights reserved.
//

#import "HotCityCell.h"
#import "HotCityModel.h"
#import "RecommendHttpTool.h"


@interface HotCityCell ()
{
    NSMutableArray *_hotCitiesArr;
}

@end

@implementation HotCityCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellIndertifer = @"HotCityCell";
    HotCityCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndertifer];
    if (!cell) {
        cell = [[HotCityCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIndertifer];
    }
    return cell;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = KColor(244, 244, 244);
        
        [RecommendHttpTool getHotCitiesInfo:^(NSMutableArray *resultArray) {
            _hotCitiesArr = resultArray;
        }];
        
        [self initUI];
        
    }
    return self;
}


-(void)initUI{
    
    CGFloat buttonW = HotCityButtonWith;
    CGFloat buttonH = HotCityButtonHeight;
    CGFloat boardWidth = (SCREEN_WIDTH - 3*buttonW - 30)/2;
    int padding = HotCityButtonMargin;
    
    for (int i = 0; i<= 14; i++) {
        HotCityModel *cityModel = _hotCitiesArr[i];
        //定位到的城市
        UIButton *locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        locationBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        locationBtn.tag = i ;
        locationBtn.layer.borderWidth = 0.4;
        locationBtn.layer.cornerRadius = 5;
        locationBtn.backgroundColor = [UIColor whiteColor];
        [locationBtn setTitle:cityModel.name forState:UIControlStateNormal];
        [locationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [locationBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [locationBtn addTarget:self action:@selector(locationBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        if (i <= 2) {
            locationBtn.frame = CGRectMake((buttonW + boardWidth)*i + HMStatusCellMargin, padding, buttonW, buttonH);
        }else{
            int j = i%3;
            int j1 = (i%15)/3;
            locationBtn.frame = CGRectMake((buttonW + boardWidth)*j + HMStatusCellMargin,j1*(buttonH + padding) + padding, buttonW, buttonH);
        }
        [self.contentView addSubview:locationBtn];
    }
}

-(void)locationBtnAction:(UIButton *)sender{
    HotCityModel *cityModel = _hotCitiesArr[sender.tag];
    
}


+(CGFloat)getCellHeight{
    return HotCityButtonMargin*7 + HotCityButtonHeight*5;
}

@end
