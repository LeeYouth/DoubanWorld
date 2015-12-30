//
//  DetialSecondCell.m
//  DoubanWorlds
//
//  Created by LYoung on 15/12/30.
//  Copyright © 2015年 LYoung. All rights reserved.
//

#import "DetialSecondCell.h"
#import "RecommendModel.h"

#define IntroduceFont 15.f
#define TitleFont 20.f

@interface DetialSecondCell ()
{
    UIImageView *_iconImageView;
    UILabel *_titleLabel;
    
    UILabel *_discussCount;
    
    UIView *_lineView;
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
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        
        [self initUI];
        
        [self setttingViewAtuoLayout];
        
    }
    return self;
}

-(void)initUI{
    
    _iconImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_iconImageView];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.font = [UIFont systemFontOfSize:IntroduceFont];
    [self.contentView addSubview:_titleLabel];
    
    _discussCount = [[UILabel alloc] init];
    _discussCount.textAlignment = NSTextAlignmentRight;
    _discussCount.textColor = [UIColor lightGrayColor];
    _discussCount.backgroundColor = [UIColor clearColor];
    _discussCount.font = [UIFont systemFontOfSize:13.f];
    [self.contentView addSubview:_discussCount];
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = [AppTools colorWithHexString:@"#F0F0F0"];
    [self.contentView addSubview:_lineView];
    
    
}

-(void)setttingViewAtuoLayout{
    
    int magin = 20;
    
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.with.top.mas_equalTo(@(magin));
        make.size.mas_equalTo(CGSizeMake(magin, magin));
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconImageView.mas_right).offset(HMStatusCellMargin);
        make.top.equalTo(_iconImageView);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
    CGFloat X = SCREEN_WIDTH - 30 - 100;
    [_discussCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@(X));
        make.top.equalTo(_titleLabel.mas_top);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
    int offSet =  - 1;
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - HMStatusCellMargin, 1));
        make.left.mas_equalTo(@(HMStatusCellMargin));
        make.top.equalTo(self.contentView.mas_bottom).offset(offSet);
    }];
}

-(void)setModel:(RecommendModel *)model{
    _model = model;
    
    _iconImageView.backgroundColor = [UIColor redColor];
    
    _discussCount.text = [NSString stringWithFormat:@"%@人",model.wisher_count];
    
}

-(void)setTitle:(NSString *)title{
    _title = title;
    
    _titleLabel.text = title;
}

-(void)setIsHidden:(BOOL)isHidden{
    _isHidden = isHidden;
    
    if (isHidden) {
        _discussCount.hidden = YES;
    }else{
        _discussCount.hidden = NO;
    }
}


+(CGFloat)getCellHeight{
    return 60;
}



@end
