//
//  MovieDetailIntroCell.m
//  DoubanWorlds
//
//  Created by LYoung on 16/1/20.
//  Copyright © 2016年 LYoung. All rights reserved.
//

#import "MovieDetailIntroCell.h"
#import "DetailMovieModel.h"

#define IntroduceFont 15.f
#define UnfoldButtonFont 17.f

@interface MovieDetailIntroCell()
{
    DetailMovieModel *_tmpModel;
    UILabel *_introLabel;
    
    UIView *_lineView;
    
    UIView *_btnsView;//盛放两个button
    
    UIButton *_wantSee;
    UIButton *_haveSee;

}

@end

@implementation MovieDetailIntroCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellIndertifer = @"MovieDetailIntroCell";
    MovieDetailIntroCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndertifer];
    if (!cell) {
        cell = [[MovieDetailIntroCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIndertifer];
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
    
    _btnsView = [[UIView alloc] init];
    _btnsView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_btnsView];
    
    _wantSee = [UIButton buttonWithType:UIButtonTypeCustom];
    _wantSee.layer.cornerRadius = 8;
    _wantSee.layer.borderColor = [UIColor orangeColor].CGColor;
    _wantSee.layer.borderWidth = 1;
    _wantSee.layer.masksToBounds = YES;
    [_wantSee setTitle:@"想看" forState:UIControlStateNormal];
    [_wantSee setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_wantSee setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
    [_wantSee addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_btnsView addSubview:_wantSee];

    _haveSee = [UIButton buttonWithType:UIButtonTypeCustom];
    _haveSee.layer.cornerRadius = 8;
    _haveSee.layer.borderColor = [UIColor orangeColor].CGColor;
    _haveSee.layer.borderWidth = 1;
    _haveSee.layer.masksToBounds = YES;
    [_haveSee setTitle:@"看过" forState:UIControlStateNormal];
    [_haveSee setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_haveSee setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
    [_haveSee addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_btnsView addSubview:_haveSee];
    
    
    _introLabel = [[UILabel alloc] init];
    _introLabel.numberOfLines = 0;
    _introLabel.font = [UIFont systemFontOfSize:IntroduceFont];
    _introLabel.textColor = [UIColor blackColor];
    _introLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_introLabel];
    
    _unfoldBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _unfoldBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16.f];
    [_unfoldBtn setTitle:@"展开" forState:UIControlStateNormal];
    [_unfoldBtn setTitle:@"展开" forState:UIControlStateHighlighted];
    [_unfoldBtn addTarget:self action:@selector(onTap) forControlEvents:UIControlEventTouchUpInside];
    [_unfoldBtn setTitleColor:TheThemeColor forState:UIControlStateNormal];
    [_unfoldBtn setTitleColor:TheThemeColor forState:UIControlStateHighlighted];
    [self.contentView addSubview:_unfoldBtn];
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = [AppTools colorWithHexString:@"#F0F0F0"];
    [self.contentView addSubview:_lineView];
    
}

-(void)setupLayout{
    
    [_btnsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView);
        make.left.and.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(75);
    }];
    
    int padding = 10;
    int btnPaddding = HMStatusCellMargin;
    
   [_introLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.mas_equalTo(self.contentView).offset(padding);
       make.right.mas_equalTo(self.contentView).offset(-padding);
       make.top.equalTo(_btnsView.mas_bottom);
   }];
    
    [_unfoldBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(_introLabel);
        make.top.equalTo(_introLabel.mas_bottom).offset(btnPaddding);
        make.height.mas_equalTo(20);
    }];
    
    int offSet =  - 1;
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - HMStatusCellMargin, 1));
        make.left.mas_equalTo(@(HMStatusCellMargin));
        make.top.equalTo(self.contentView.mas_bottom).offset(offSet);
    }];
    
    
    [_wantSee mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_introLabel.mas_left);
        make.top.mas_equalTo(20);
        make.right.equalTo(_haveSee.mas_left).offset(-20);
        make.height.mas_equalTo(35);
        make.width.equalTo(_haveSee);
    }];
    
    [_haveSee mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_introLabel.mas_right);
        make.top.mas_equalTo(20);
        make.left.equalTo(_wantSee.mas_right).offset(20);
        make.height.mas_equalTo(35);
        make.width.equalTo(_wantSee);

    }];
}


- (void)configCellWithModel:(DetailMovieModel *)model{
    _tmpModel = model;
    
    NSString *introduceStr = nil;
    if ([NSString checkConvertNull:model.summary]) {
        introduceStr = @"";
    }else{
        introduceStr = model.summary;
    }

    _introLabel.attributedText = [AppTools setLineSpacingWith:introduceStr lineSpacing:6];
    
    int padding = 10;

    if (model.isExpanded) {//展开
        [_introLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(padding);
            make.right.mas_equalTo(self.contentView).offset(-padding);
            make.top.equalTo(_btnsView.mas_bottom);
        }];
    } else//非展开
    {
        [_introLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(padding);
            make.right.mas_equalTo(self.contentView).offset(-padding);
            make.top.equalTo(_btnsView.mas_bottom);
            make.height.mas_equalTo(70);
        }];
    }
}

- (void)onTap {
    _tmpModel.isExpanded = !_tmpModel.isExpanded;
    
    if (self.block) {
        self.block(self.indexPath);
    }
    
    [self configCellWithModel:_tmpModel];
    [self.contentView setNeedsUpdateConstraints];
    [self.contentView updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.contentView layoutIfNeeded];
    }];
}

- (void)buttonClick:(UIButton *)sender{
    
}

+ (CGFloat)heightWithModel:(DetailMovieModel *)model {
    MovieDetailIntroCell *cell = [[MovieDetailIntroCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MovieDetailIntroCell"];
    [cell configCellWithModel:model];
    [cell layoutIfNeeded];
    CGRect frame =  cell.unfoldBtn.frame;
    return frame.origin.y + frame.size.height + HMStatusCellMargin;
}

@end
