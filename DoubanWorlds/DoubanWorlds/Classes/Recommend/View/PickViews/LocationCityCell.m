//
//  LocationCityCell.m
//  DoubanWorlds
//
//  Created by LYoung on 15/12/28.
//  Copyright © 2015年 LYoung. All rights reserved.
//

#import "LocationCityCell.h"


@interface LocationCityCell ()
{
    UILabel *_cityIndexLabel;
    UIView *_lineView;
}
@end

@implementation LocationCityCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellIndertifer = @"LocationCityCell";
    LocationCityCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndertifer];
    if (!cell) {
        cell = [[LocationCityCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIndertifer];
    }
    return cell;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = KBackgroundColor;
        
                
        [self initUI];
    }
    return self;
}


-(void)initUI{

    
    NSString *cityName = [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentLocation];
    
    //定位到的城市
    UIButton *locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    locationBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    locationBtn.layer.borderWidth = 0.4;
    locationBtn.layer.cornerRadius = 5;
    locationBtn.backgroundColor = [UIColor whiteColor];
    [locationBtn setTitle:cityName forState:UIControlStateNormal];
    locationBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 8);
    [locationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [locationBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [locationBtn setImage:[UIImage imageNamed:@"AlbumLocationIconHL"] forState:UIControlStateNormal];
    [locationBtn addTarget:self action:@selector(locationBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:locationBtn];
    

    [locationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(HotCityButtonMargin);
        make.left.mas_equalTo(HMStatusCellMargin);
        make.size.mas_equalTo(CGSizeMake(HotCityButtonWith, HotCityButtonHeight));
    }];
}

-(void)locationBtnAction:(UIButton *)sender{
    NSString *cityName = [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentLocation];
    [[NSNotificationCenter defaultCenter] postNotificationName:kCityButtonClick object:nil userInfo:@{kCityButtonClick : cityName}];
}

+(CGFloat)getCellHeight{
    return 2*HotCityButtonMargin + HotCityButtonHeight;
}

@end
