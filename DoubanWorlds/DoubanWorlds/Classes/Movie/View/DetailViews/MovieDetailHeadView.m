//
//  MovieDetailHeadView.m
//  DoubanWorlds
//
//  Created by LYoung on 16/1/7.
//  Copyright © 2016年 LYoung. All rights reserved.
//

#import "MovieDetailHeadView.h"
#import "MovieModel.h"
#import "ZLPhotoPickerBrowserViewController.h"
#import "AvatarsModel.h"
#import "DetailMovieModel.h"
#import "RatingModel.h"

#define IntroduceFont 14.f
#define RatingFont 12.f
#define TitleFont 17.f

@interface MovieDetailHeadView ()

{
    UIImageView *_headImageView;
    
    UILabel *_titleLabel;
    UILabel *_originalTitleLabel;
    UILabel *_genresLabel;
    UILabel *_countryLabel;
    
    UIImageView *_starView;
    UILabel *_ratingLabel;
    
    UILabel *_noCommentLabel;
}

@end

@implementation MovieDetailHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
     
        
     
        
        [self setupUI];
        
        [self setupLayouts];
    }
    return self;
}
-(void)setupUI{
    
    _headImageView = [[UIImageView alloc] init];
    _headImageView.userInteractionEnabled = YES;
    [self addSubview:_headImageView];
    
    UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showHeadPortrait)];
    [_headImageView addGestureRecognizer:tapG];
    
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.font = [UIFont boldSystemFontOfSize:TitleFont];
    [self addSubview:_titleLabel];
    
    _originalTitleLabel = [[UILabel alloc] init];
    _originalTitleLabel.numberOfLines = 0;
    _originalTitleLabel.textColor = [UIColor whiteColor];
    _originalTitleLabel.backgroundColor = [UIColor clearColor];
    _originalTitleLabel.font = [UIFont systemFontOfSize:IntroduceFont];
    [self addSubview:_originalTitleLabel];
    
    _genresLabel = [[UILabel alloc] init];
    _genresLabel.textColor = [UIColor whiteColor];
    _genresLabel.backgroundColor = [UIColor clearColor];
    _genresLabel.font = [UIFont systemFontOfSize:IntroduceFont];
    [self addSubview:_genresLabel];
    
    _countryLabel = [[UILabel alloc] init];
    _countryLabel.textColor = [UIColor whiteColor];
    _countryLabel.backgroundColor = [UIColor clearColor];
    _countryLabel.font = [UIFont systemFontOfSize:IntroduceFont];
    [self addSubview:_countryLabel];
    
    
    _starView = [[UIImageView alloc] init];
    _starView.backgroundColor = [UIColor clearColor];
    [self addSubview:_starView];
    
    _ratingLabel = [[UILabel alloc] init];
    _ratingLabel.textColor = [UIColor whiteColor];
    _ratingLabel.backgroundColor = [UIColor clearColor];
    _ratingLabel.font = [UIFont systemFontOfSize:RatingFont];
    [self addSubview:_ratingLabel];
    
    _noCommentLabel = [[UILabel alloc] init];
    _noCommentLabel.textColor = [UIColor whiteColor];
    _noCommentLabel.backgroundColor = [UIColor clearColor];
    _noCommentLabel.font = [UIFont systemFontOfSize:IntroduceFont];
    [self addSubview:_noCommentLabel];
    _noCommentLabel.text = @"暂无评分";
}

-(void)setupLayouts{
    
    int padding = HMStatusCellMargin;
    
    int margin = 5;
    
    CGFloat H = 20;
    
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(120, 160));
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left).offset(padding);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headImageView.mas_right).offset(padding);
        make.right.equalTo(self.mas_right).offset(-padding);
        make.height.mas_equalTo(@(H));
        make.top.equalTo(_headImageView.mas_top);
    }];
    
    [_originalTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.left.equalTo(_titleLabel);
//        make.height.mas_equalTo(@(H));
        make.top.equalTo(_titleLabel.mas_bottom).offset(margin);
    }];
    
    [_genresLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.left.equalTo(_titleLabel);
        make.height.mas_equalTo(@(H));
        make.top.equalTo(_originalTitleLabel.mas_bottom).offset(margin);
    }];
    
    [_countryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.left.equalTo(_titleLabel);
        make.height.mas_equalTo(@(H));
        make.top.equalTo(_genresLabel.mas_bottom).offset(margin);
    }];
    
    [_starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_left);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.size.mas_equalTo(CGSizeMake(60, 10));
    }];
    
    [_ratingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_starView.mas_right).offset(margin);
        make.bottom.equalTo(self.mas_bottom).offset(-margin);
        make.right.equalTo(self.mas_right).offset(10);
        make.height.mas_equalTo(@(H));
    }];

    [_noCommentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.left.equalTo(_titleLabel);
        make.bottom.equalTo(self.mas_bottom).offset(-margin);
        make.height.mas_equalTo(@(H));
    }];
}



-(void)setModel:(MovieModel *)model{
    _model = model;
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:model.images.medium] placeholderImage:[UIImage imageNamed:@"detail_defultImage.png"]];
    
    _titleLabel.text = model.title;
    
    _originalTitleLabel.text = model.original_title;
    
    NSString *genres = [NSString stringWithFormat:@"%@",[model.genres componentsJoinedByString:@" "]];

    _genresLabel.text = genres;
    
    _starView.image = [UIImage imageNamed:[AppTools formatRating:model.rating.average]];
    
    if ([model.rating.average intValue] > 0) {
        _noCommentLabel.hidden = YES;
        _starView.hidden = NO;
        _ratingLabel.hidden = NO;
        _ratingLabel.text = [NSString stringWithFormat:@"%@ (%@人评论)",model.rating.average,[AppTools formatCountstr:model.collect_count]];
    }else{
        _noCommentLabel.hidden = NO;
        _starView.hidden = YES;
        _ratingLabel.hidden = YES;
    }
}

-(void)setInfoModel:(DetailMovieModel *)infoModel{
    _infoModel = infoModel;
    
    NSString *countryString = [NSString stringWithFormat:@"%@",[infoModel.countries componentsJoinedByString:@" "]];
    _countryLabel.text = [NSString stringWithFormat:@"%@ | %@",countryString,infoModel.year];

    
}


#pragma mark 传入imageView放大
- (void)showHeadPortrait{
    ZLPhotoPickerBrowserViewController *browserVc = [[ZLPhotoPickerBrowserViewController alloc] init];
    [browserVc showHeadPortrait:_headImageView originUrl:_model.images.large];
}

@end
