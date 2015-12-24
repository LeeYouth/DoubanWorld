//
//  HotActivityCell.m
//  DoubanWorlds
//
//  Created by LYoung on 15/12/23.
//  Copyright © 2015年 LYoung. All rights reserved.
//

#import "HotActivityCell.h"
#import "RecommendModel.h"

#define IntroduceFont 13.f
#define TitleFont 17.f

@interface HotActivityCell ()
{
    UIImageView *_imageView;
    UILabel *_categoryLabel;
    UILabel *_titleLabel;
    UILabel *_contentLabel;
    
    UILabel *_timeLabel;
    UILabel *_addressLabel;
    
    UIView *_lineView;
}

@end

@implementation HotActivityCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellIndertifer = @"HotActivityCell";
    HotActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndertifer];
    if (!cell) {
        cell = [[HotActivityCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIndertifer];
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
    _imageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_imageView];
    
    _categoryLabel = [[UILabel alloc] init];
    _categoryLabel.textColor = [UIColor lightGrayColor];
    _categoryLabel.backgroundColor = [UIColor clearColor];
    _categoryLabel.font = [UIFont systemFontOfSize:IntroduceFont];
    [self.contentView addSubview:_categoryLabel];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.numberOfLines = 0;
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.font = [UIFont boldSystemFontOfSize:TitleFont];
    [self.contentView addSubview:_titleLabel];
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.textColor = [UIColor lightGrayColor];
    _timeLabel.font = [UIFont systemFontOfSize:IntroduceFont];
    [self.contentView addSubview:_timeLabel];
    
    _addressLabel = [[UILabel alloc] init];
    _addressLabel.numberOfLines = 0;
    _addressLabel.textColor = [UIColor lightGrayColor];
    _addressLabel.font = [UIFont systemFontOfSize:IntroduceFont];
    [self.contentView addSubview:_addressLabel];
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = [AppTools colorWithHexString:@"#F0F0F0"];
    [self.contentView addSubview:_lineView];

}


-(void)setttingViewAtuoLayout{
    
    int magin = HMStatusCellMargin;
    int padding = 10;
    
    CGFloat w = SCREEN_WIDTH - 2*padding - magin - 80;
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 120));
        make.top.mas_equalTo(@(magin));
        make.left.mas_equalTo(@(padding));
    }];
    
    [_categoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageView);
        make.left.equalTo(_imageView.mas_right).offset(magin);
        make.width.mas_equalTo(@(w));
        make.height.mas_equalTo(@(20));
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(_categoryLabel);
        make.top.mas_equalTo(_categoryLabel.mas_bottom).offset(padding);
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.with.right.equalTo(_categoryLabel);
        make.top.equalTo(_titleLabel.mas_bottom).offset(padding);
    }];
    
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.with.right.equalTo(_categoryLabel);
        make.top.equalTo(_timeLabel.mas_bottom);
    }];
    
    int offSet =  - 1;

    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 1));
        make.left.mas_equalTo(@0);
        make.top.equalTo(self.contentView.mas_bottom).offset(offSet);
    }];

}








-(void)setModel:(RecommendModel *)model{
    _model = model;
    

    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:nil];
    
    _categoryLabel.text = model.category_name;
    
    _titleLabel.attributedText = [AppTools setLineSpacingWith:model.title lineSpacing:6];
    
    
    NSRange beginRange = NSMakeRange (0, 10);
    NSString *beginTime = [model.begin_time substringWithRange:beginRange];
    NSRange endRange = NSMakeRange (0, 10);
    NSString *endTime = [model.end_time substringWithRange:endRange];
    NSString *timeString = [NSString stringWithFormat:@"时间: %@ ~ %@",beginTime,endTime];
    _timeLabel.attributedText = [AppTools setLineSpacingWith:timeString lineSpacing:6];

    NSString *finallyString = [model.address stringByReplacingOccurrencesOfString:model.loc_name withString:@""];
    NSString *addressString = [NSString stringWithFormat:@"地点:%@",finallyString];
    _addressLabel.attributedText = [AppTools setLineSpacingWith:addressString lineSpacing:2];
    
}



+(CGFloat)getCellHeight:(RecommendModel *)model{
    CGFloat imageBottom = 120 + HMStatusCellMargin;
    
    CGFloat timeH = 20;
    
    int magin = HMStatusCellMargin;
    int padding = 10;
    CGFloat w = SCREEN_WIDTH - 2*padding - magin - 80;

    CGSize maxSize = CGSizeMake(w, MAXFLOAT);
    CGSize titleSize = [model.title attrStrSizeWithFont:[UIFont systemFontOfSize:TitleFont] andmaxSize:maxSize lineSpacing:6];

    NSString *finallyString = [model.address stringByReplacingOccurrencesOfString:model.loc_name withString:@""];
    NSString *addressString = [NSString stringWithFormat:@"地点:%@",finallyString];
    CGSize addressSize = [addressString attrStrSizeWithFont:[UIFont systemFontOfSize:IntroduceFont] andmaxSize:maxSize lineSpacing:2];
    
    CGFloat allH = addressSize.height + titleSize.height + 2*padding + 2*timeH + HMStatusCellMargin;
    if (imageBottom > allH) {
        return imageBottom + HMStatusCellMargin;
    }else{
        return allH + HMStatusCellMargin;
    }
}








@end
