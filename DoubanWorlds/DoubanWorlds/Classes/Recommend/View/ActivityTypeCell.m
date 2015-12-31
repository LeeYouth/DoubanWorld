//
//  ActivityTypeCell.m
//  DoubanWorlds
//
//  Created by LYoung on 15/12/31.
//  Copyright © 2015年 LYoung. All rights reserved.
//

#import "ActivityTypeCell.h"

@interface ActivityTypeCell ()
{
    UIImageView *_iconImageView;
    UILabel *_titleLabel;
    UIView *_lineView;
}

@end

@implementation ActivityTypeCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellIndertifer = @"ActivityTypeCell";
    ActivityTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndertifer];
    if (!cell) {
        cell = [[ActivityTypeCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIndertifer];
    }
    return cell;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        _iconImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_iconImageView];
        

        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = TheThemeColor;
        _titleLabel.font = [UIFont boldSystemFontOfSize:15.f];
        [self.contentView addSubview:_titleLabel];
        
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [AppTools colorWithHexString:@"#F0F0F0"];
        [self.contentView addSubview:_lineView];
        
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(@8);
            make.size.mas_equalTo(CGSizeMake(24, 24));
        }];
        
        int padding = 20 ;
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_iconImageView.mas_right).offset(padding);
            make.top.mas_equalTo(@10);
            make.size.mas_equalTo(CGSizeMake(80, 20));
        }];
        
        int offSet =  - 1;

        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - HMStatusCellMargin, 1));
            make.left.mas_equalTo(@(HMStatusCellMargin));
            make.top.equalTo(self.contentView.mas_bottom).offset(offSet);
        }];
        
    }
    return self;
}

-(void)setTitle:(NSString *)title{
    _title = title;
    _titleLabel.text = title;
}

-(void)setImageName:(NSString *)imageName{
    _imageName = imageName;
    _iconImageView.image = [UIImage imageNamed:imageName];
}

+(CGFloat)getCellHeight{
    return 40;
}




@end
