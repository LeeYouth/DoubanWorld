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
#define TitleFont 20.f

@interface DetailFirstRowCell ()
{
    UILabel *_titleLabel;
    UILabel *_timeLabel;
    
    UIButton *_interestedBtn;
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
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
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

-(void)interestedBtnAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        _interestedBtn.layer.cornerRadius = 8;
        _interestedBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _interestedBtn.layer.borderWidth = 1;
        _interestedBtn.layer.masksToBounds = YES;
    }else{
        _interestedBtn.layer.cornerRadius = 8;
        _interestedBtn.layer.borderColor = [UIColor orangeColor].CGColor;
        _interestedBtn.layer.borderWidth = 1;
        _interestedBtn.layer.masksToBounds = YES;
    }
}


-(void)setttingViewAtuoLayout{
    
    int magin = HMStatusCellMargin;
    
    CGFloat w = SCREEN_WIDTH - 2*HMStatusCellMargin;
    
    int padding = 10;
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@20);
        make.left.mas_equalTo(@(magin));
        make.width.mas_equalTo(@(w));
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(padding);
        make.left.with.right.equalTo(_titleLabel);
    }];
    
    [_interestedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_timeLabel.mas_bottom).offset(magin);
        make.left.equalTo(self.contentView).offset(magin);
        make.right.equalTo(self.contentView).offset(-magin);
        make.height.mas_equalTo(@40);
    }];
    
}








-(void)setModel:(RecommendModel *)model{
    _model = model;
    
    _titleLabel.attributedText = [AppTools setLineSpacingWith:model.title lineSpacing:6];
    
    
    NSRange beginRange = NSMakeRange (0, 10);
    NSString *beginTime = [model.begin_time substringWithRange:beginRange];
    NSRange endRange = NSMakeRange (0, 10);
    NSString *endTime = [model.end_time substringWithRange:endRange];
    
    NSString *finallyString = [model.address stringByReplacingOccurrencesOfString:model.loc_name withString:@""];
    NSString *addressString = [NSString stringWithFormat:@"%@",finallyString];
    
    NSString *timeString = [NSString stringWithFormat:@"%@人参加/%@ ~ %@/%@",model.participant_count,beginTime,endTime,addressString];
    _timeLabel.attributedText = [AppTools setLineSpacingWith:timeString lineSpacing:2];
    
}

+(CGFloat)getCellHeight:(RecommendModel *)model{
    
    CGFloat bottomHM = 20;
    
    int magin = HMStatusCellMargin;

    CGFloat w = SCREEN_WIDTH - 2*magin;
    CGFloat btnH = 40;
    
    CGSize maxSize = CGSizeMake(w, MAXFLOAT);
    CGSize titleSize = [model.title attrStrSizeWithFont:[UIFont systemFontOfSize:TitleFont] andmaxSize:maxSize lineSpacing:6];
    
    NSRange beginRange = NSMakeRange (0, 10);
    NSString *beginTime = [model.begin_time substringWithRange:beginRange];
    NSRange endRange = NSMakeRange (0, 10);
    NSString *endTime = [model.end_time substringWithRange:endRange];
    
    NSString *finallyString = [model.address stringByReplacingOccurrencesOfString:model.loc_name withString:@""];
    NSString *addressString = [NSString stringWithFormat:@"%@",finallyString];
    
    NSString *timeString = [NSString stringWithFormat:@"%@人参加/%@ ~ %@/%@",model.participant_count,beginTime,endTime,addressString];
    CGSize addressSize = [timeString attrStrSizeWithFont:[UIFont systemFontOfSize:IntroduceFont] andmaxSize:maxSize lineSpacing:2];
    
    int padding = 10;

    CGFloat allH = addressSize.height + titleSize.height + 2*magin + btnH + bottomHM + padding;

    return allH;
}

@end
