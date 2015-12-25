//
//  CityIndexCell.m
//  DoubanWorlds
//
//  Created by LYoung on 15/12/25.
//  Copyright © 2015年 LYoung. All rights reserved.
//

#import "CityIndexCell.h"

@interface CityIndexCell ()

{
    UILabel *_cityIndexLabel;
    UIView *_lineView;
}

@end

@implementation CityIndexCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellIndertifer = @"CityIndexCell";
    CityIndexCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndertifer];
    if (!cell) {
        cell = [[CityIndexCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIndertifer];
    }
    return cell;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];

        
        _cityIndexLabel = [[UILabel alloc] init];
        _cityIndexLabel.backgroundColor = [UIColor clearColor];
        _cityIndexLabel.textColor = [UIColor blackColor];
        _cityIndexLabel.font = [UIFont systemFontOfSize:15.0f];
        [self.contentView addSubview:_cityIndexLabel];
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [AppTools colorWithHexString:@"#F0F0F0"];
        [self.contentView addSubview:_lineView];
        
        
        [_cityIndexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(HMStatusCellMargin);
            make.top.equalTo(self.contentView).offset(10);
            make.width.mas_equalTo(@(SCREEN_WIDTH - 30));
            make.height.mas_equalTo(@20);
        }];
        
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 15, 0.8));
            make.left.mas_equalTo(@15);
            make.top.equalTo(self.contentView.mas_bottom).offset(-0.8);
        }];

    }
    return self;
}

-(void)setCityName:(NSString *)cityName{
    _cityName = cityName;
    
    _cityIndexLabel.text = cityName;
}


+(CGFloat)getCellHeight{
    return 40;
}



@end
