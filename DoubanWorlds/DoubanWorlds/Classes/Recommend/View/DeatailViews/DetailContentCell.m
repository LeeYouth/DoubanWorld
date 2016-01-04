//
//  DetailContentCell.m
//  DoubanWorlds
//
//  Created by LYoung on 15/12/30.
//  Copyright © 2015年 LYoung. All rights reserved.
//

#import "DetailContentCell.h"
#import "RecommendModel.h"

#define ContentFont 17.f

@interface DetailContentCell ()
{
    UILabel *_introL;
    UILabel *_contentLabel;
    
}

@end

@implementation DetailContentCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellIndertifer = @"DetailContentCell";
    DetailContentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndertifer];
    if (!cell) {
        cell = [[DetailContentCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIndertifer];
    }
    return cell;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        
        [self initUI];
        
        [self setttingViewAtuoLayout];
        
    }
    return self;
}

-(void)initUI{
    
    _introL = [[UILabel alloc] init];
    _introL.text = @"简介";
    _introL.textColor = [UIColor lightGrayColor];
    _introL.font = [UIFont boldSystemFontOfSize:ContentFont];
    [self.contentView addSubview:_introL];
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.textColor = [UIColor blackColor];
    _contentLabel.backgroundColor = [UIColor clearColor];
    _contentLabel.numberOfLines = 0;
    _contentLabel.font = [UIFont boldSystemFontOfSize:ContentFont];
    [self.contentView addSubview:_contentLabel];
    
    
}

-(void)setttingViewAtuoLayout{
    
    int magin = 20;
    
    [_introL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@(HMStatusCellMargin));
        make.top.mas_equalTo(@(magin));
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
    
    CGFloat w = SCREEN_WIDTH - 2*HMStatusCellMargin;
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_introL.mas_bottom).offset(magin);
        make.left.mas_equalTo(@(HMStatusCellMargin));
        make.width.mas_equalTo(@(w));
    }];
    
}

-(void)setModel:(RecommendModel *)model{
    _model = model;

    _contentLabel.attributedText = [model.content linkAttriWithLineSpacing:4 urlColor:TheThemeColor];

}

+(CGFloat)getCellHeight:(RecommendModel *)model{
    
    CGFloat w = SCREEN_WIDTH - 2*HMStatusCellMargin;

    CGSize maxSize = CGSizeMake(w, MAXFLOAT);
    CGSize titleSize = [model.content attrStrSizeWithFont:[UIFont systemFontOfSize:ContentFont] andmaxSize:maxSize lineSpacing:4];

    return 20*4 + titleSize.height;
}



@end
