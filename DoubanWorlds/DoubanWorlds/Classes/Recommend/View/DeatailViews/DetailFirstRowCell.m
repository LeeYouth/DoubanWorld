//
//  DetailFirstRowCell.m
//  DoubanWorlds
//
//  Created by LYoung on 15/12/30.
//  Copyright © 2015年 LYoung. All rights reserved.
//

#import "DetailFirstRowCell.h"

#import "RecommendModel.h"

#define IntroduceFont 13.f
#define TitleFont 17.f

@interface DetailFirstRowCell ()
{
    UILabel *_titleLabel;
    UILabel *_contentLabel;
    
    UILabel *_timeLabel;
    UILabel *_addressLabel;
    
    UIView *_lineView;
}

@end

@implementation DetailFirstRowCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellIndertifer = @"DetailFirstRowCell";
    DetailFirstRowCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndertifer];
    if (!cell) {
        cell = [[DetailFirstRowCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIndertifer];
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
    
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.with.right.equalTo(_titleLabel);
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
    
    CGFloat H = 20;
    
    int magin = HMStatusCellMargin;
    int padding = 10;
    CGFloat w = SCREEN_WIDTH - 2*magin;
    
    CGSize maxSize = CGSizeMake(w, MAXFLOAT);
    CGSize titleSize = [model.title attrStrSizeWithFont:[UIFont systemFontOfSize:TitleFont] andmaxSize:maxSize lineSpacing:6];
    
    NSString *finallyString = [model.address stringByReplacingOccurrencesOfString:model.loc_name withString:@""];
    NSString *addressString = [NSString stringWithFormat:@"地点:%@",finallyString];
    CGSize addressSize = [addressString attrStrSizeWithFont:[UIFont systemFontOfSize:IntroduceFont] andmaxSize:maxSize lineSpacing:2];
    
    CGFloat allH = addressSize.height + titleSize.height + 2*padding + 2*H;

    return allH;
}

@end
