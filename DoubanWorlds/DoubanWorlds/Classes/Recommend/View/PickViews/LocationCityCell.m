//
//  LocationCityCell.m
//  DoubanWorlds
//
//  Created by LYoung on 15/12/28.
//  Copyright © 2015年 LYoung. All rights reserved.
//

#import "LocationCityCell.h"
#import "LocationManager.h"

@interface LocationCityCell ()
{
    UIButton *_locationBtn;
    UILabel *_cityIndexLabel;
    UIView *_lineView;
}

@property (nonatomic, copy) NSString *locName;//当前城市ID

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
        
        //定位当前城市
        LocationManager *manager = [LocationManager sharedFOLClient];
        __weak LocationCityCell *weekSelf = self;
        [manager currentLocation:^(CLLocation *currentLocation, NSString *cityName) {
            
            weekSelf.locName = [cityName copy];
            
            [_locationBtn setTitle:cityName forState:UIControlStateNormal];

        }];

    }
    return self;
}


-(void)initUI{

    
    //定位到的城市
    _locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _locationBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _locationBtn.layer.borderWidth = 0.4;
    _locationBtn.layer.cornerRadius = 5;
    _locationBtn.backgroundColor = [UIColor whiteColor];
    [_locationBtn setTitle:@"定位中" forState:UIControlStateNormal];
    _locationBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 8);
    [_locationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_locationBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_locationBtn setImage:[UIImage imageNamed:@"AlbumLocationIconHL"] forState:UIControlStateNormal];
    [_locationBtn addTarget:self action:@selector(locationBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_locationBtn];
    

    [_locationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(HotCityButtonMargin);
        make.left.mas_equalTo(HMStatusCellMargin);
        make.size.mas_equalTo(CGSizeMake(HotCityButtonWith, HotCityButtonHeight));
    }];
}

-(void)locationBtnAction:(UIButton *)sender{
    if ([self.locName checkConvertNull]) {

    }else{
        NSString *cityName = [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentLocation];
        [[NSNotificationCenter defaultCenter] postNotificationName:kCityButtonClick object:nil userInfo:@{kCityButtonClick : cityName}];
    }
}

+(CGFloat)getCellHeight{
    return 2*HotCityButtonMargin + HotCityButtonHeight;
}

@end
