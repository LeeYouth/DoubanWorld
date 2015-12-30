//
//  DetialSecondCell.m
//  DoubanWorlds
//
//  Created by LYoung on 15/12/30.
//  Copyright © 2015年 LYoung. All rights reserved.
//

#import "DetialSecondCell.h"
#import "RecommendModel.h"

#define IntroduceFont 13.f
#define TitleFont 20.f

@interface DetialSecondCell ()
{
    UIImageView *_iconImageView;
    UILabel *_timeLabel;
    
    UIButton *_interestedBtn;
}

@end

@implementation DetialSecondCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellIndertifer = @"DetialSecondCell";
    DetialSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndertifer];
    if (!cell) {
        cell = [[DetialSecondCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIndertifer];
    }
    return cell;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        //        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        [self initUI];
        
        [self setttingViewAtuoLayout];
        
    }
    return self;
}

-(void)initUI{
    
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.numberOfLines = 0;
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.font = [UIFont boldSystemFontOfSize:TitleFont];
    [self.contentView addSubview:_titleLabel];
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.numberOfLines = 0;
    _timeLabel.textColor = [UIColor lightGrayColor];
    _timeLabel.font = [UIFont systemFontOfSize:IntroduceFont];
    [self.contentView addSubview:_timeLabel];
    
    _interestedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _interestedBtn.layer.cornerRadius = 8;
    _interestedBtn.layer.borderColor = [UIColor orangeColor].CGColor;
    _interestedBtn.layer.borderWidth = 1;
    _interestedBtn.layer.masksToBounds = YES;
    [_interestedBtn setTitle:@"感兴趣" forState:UIControlStateNormal];
    [_interestedBtn setTitle:@"已感兴趣" forState:UIControlStateSelected];
    [_interestedBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_interestedBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
    [_interestedBtn addTarget:self action:@selector(interestedBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_interestedBtn];
    
}

-(void)setttingViewAtuoLayout{
    
    int magin = HMStatusCellMargin;
    
    CGFloat w = SCREEN_WIDTH - 2*HMStatusCellMargin;
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@20);
        make.left.mas_equalTo(@(magin));
        make.width.mas_equalTo(@(w));
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom);
        make.left.with.right.equalTo(_titleLabel);
    }];
    
    [_interestedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_timeLabel.mas_bottom).offset(magin);
        make.left.equalTo(self.contentView).offset(magin);
        make.right.equalTo(self.contentView).offset(-magin);
        make.height.mas_equalTo(@40);
    }];
    
}



@end
