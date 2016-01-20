//
//  HotMovieCell.m
//  DoubanWorlds
//
//  Created by LYoung on 16/1/5.
//  Copyright © 2016年 LYoung. All rights reserved.
//

#import "HotMovieCell.h"
#import "MovieModel.h"
#import "AvatarsModel.h"
#import "RatingModel.h"
#import "CastModel.h"


#define TitleFont 17.f
#define IntroduceFont 12.f

@interface HotMovieCell ()
{
    UIImageView *_iconImageView;
    UILabel *_directorLabel;
    UILabel *_castsLabel;
    UILabel *_averageLabel;//分数
    UILabel *_titleLabel;
    UIImageView *_starView;
    UIView *_lineView;
    
    UILabel *_nocommentLabel;//
}

@end

@implementation HotMovieCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellIndertifer = @"HotMovieCell";
    HotMovieCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndertifer];
    if (!cell) {
        cell = [[HotMovieCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIndertifer];
    }
    return cell;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        
        
        [self setupUI];
        
        [self setupLayout];
        
    }
    return self;
}


-(void)setupUI{
    _iconImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_iconImageView];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.font = [UIFont systemFontOfSize:TitleFont];
    [self.contentView addSubview:_titleLabel];
    
    _starView = [[UIImageView alloc] init];
    [self.contentView addSubview:_starView];
    
    _averageLabel = [[UILabel alloc] init];
    _averageLabel.backgroundColor = [UIColor clearColor];
    _averageLabel.textColor = [UIColor lightGrayColor];
    _averageLabel.font = [UIFont systemFontOfSize:IntroduceFont];
    [self.contentView addSubview:_averageLabel];
    
    _directorLabel = [[UILabel alloc] init];
    _directorLabel.textColor = [UIColor lightGrayColor];
    _directorLabel.backgroundColor = [UIColor clearColor];
    _directorLabel.font = [UIFont systemFontOfSize:IntroduceFont];
    [self.contentView addSubview:_directorLabel];
    
    _castsLabel = [[UILabel alloc] init];
    _castsLabel.backgroundColor = [UIColor clearColor];
    _castsLabel.textColor = [UIColor lightGrayColor];
    _castsLabel.numberOfLines = 0;
    _castsLabel.font = [UIFont systemFontOfSize:IntroduceFont];
    [self.contentView addSubview:_castsLabel];
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = [AppTools colorWithHexString:@"#F0F0F0"];
    [self.contentView addSubview:_lineView];
    
    
    _nocommentLabel = [[UILabel alloc] init];
    _nocommentLabel.backgroundColor = [UIColor clearColor];
    _nocommentLabel.textColor = [UIColor lightGrayColor];
    _nocommentLabel.font = [UIFont systemFontOfSize:IntroduceFont];
    _nocommentLabel.text = @"暂无评分";
    [self.contentView addSubview:_nocommentLabel];

}

-(void)setupLayout{
    int magin = HMStatusCellMargin;
    int padding = 5;
    
    int padding1 = 10;
    
    CGFloat w = SCREEN_WIDTH - 3*magin - 80;
    
    
    
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 120));
        make.top.mas_equalTo(@(magin));
        make.left.mas_equalTo(@(magin));
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconImageView).offset(padding);
        make.left.equalTo(_iconImageView.mas_right).offset(magin);
        make.width.mas_equalTo(@(w));
        make.height.mas_equalTo(@(20));
    }];
    
    [_starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(padding1);
        make.size.mas_equalTo(CGSizeMake(60, 10));
        make.left.equalTo(_titleLabel.mas_left);
    }];
    
    [_averageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_starView.mas_top);
        make.size.mas_equalTo(CGSizeMake(40, 10));
        make.left.equalTo(_starView.mas_right).offset(padding1);
    }];
    
    [_directorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_starView.mas_bottom).offset(padding1);
        make.left.with.height.with.equalTo(_titleLabel);
    }];
    
    [_castsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_directorLabel.mas_bottom).offset(padding);
        make.width.mas_equalTo(@(w));
        make.left.equalTo(_titleLabel.mas_left);
    }];
    
    int offSet =  - 1;

    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - HMStatusCellMargin, 1));
        make.left.mas_equalTo(@(magin));
        make.top.equalTo(self.contentView.mas_bottom).offset(offSet);
    }];
    
    
    [_nocommentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(padding);
        make.size.mas_equalTo(CGSizeMake(w, 20));
        make.left.equalTo(_titleLabel.mas_left);

    }];
    
}

-(void)setModel:(MovieModel *)model{
    _model = model;
    
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:model.images.medium]];
    
    _titleLabel.text = model.title;
    
    _starView.image = [UIImage imageNamed:[AppTools formatRating:model.rating.average]];

    if ([model.rating.average intValue] > 0) {
        _averageLabel.text = model.rating.average;
        _nocommentLabel.hidden = YES;
        _starView.hidden = NO;
        _averageLabel.hidden = NO;
    }else{
        _nocommentLabel.hidden = NO;
        _starView.hidden = YES;
        _averageLabel.hidden = YES;
    }
    
    NSMutableArray *dirArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < model.directors.count; i++) {
        CastModel *casModel = model.directors[i];
        [dirArr addObject:casModel.name];
    }
    NSString *dirString = [NSString stringWithFormat:@"导演: %@",[dirArr componentsJoinedByString:@"/ "]];
    _directorLabel.attributedText = [AppTools setLineSpacingWith:dirString lineSpacing:4];
    
    NSMutableArray *casArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < model.casts.count; i++) {
        CastModel *casModel = model.casts[i];
        [casArr addObject:casModel.name];
    }
    NSString *casString = [NSString stringWithFormat:@"演员: %@",[casArr componentsJoinedByString:@"/ "]];
    _castsLabel.attributedText = [AppTools setLineSpacingWith:casString lineSpacing:4];

}


+(CGFloat)getCellHeight:(MovieModel *)model{
//    return 150;
    
    CGFloat imageBottom = 120 + HMStatusCellMargin;
    
    CGFloat dirH = 20;
    
    int magin = HMStatusCellMargin;
    int padding = 5;

    CGFloat w = SCREEN_WIDTH - 3*magin - 80;
    
    CGSize maxSize = CGSizeMake(w, MAXFLOAT);

    NSMutableArray *casArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < model.casts.count; i++) {
        CastModel *casModel = model.casts[i];
        [casArr addObject:casModel.name];
    }
    NSString *casString = [NSString stringWithFormat:@"演员: %@",[casArr componentsJoinedByString:@"/ "]];

    CGSize casSize = [casString attrStrSizeWithFont:[UIFont systemFontOfSize:IntroduceFont] andmaxSize:maxSize lineSpacing:4];
    
    CGFloat allH = casSize.height + 4*padding + 3*dirH + HMStatusCellMargin;
    if (imageBottom > allH) {
        return imageBottom + HMStatusCellMargin;
    }else{
        return allH + HMStatusCellMargin;
    }
}


@end
