//
//  HotActivityCell.m
//  DoubanWorlds
//
//  Created by LYoung on 15/12/23.
//  Copyright © 2015年 LYoung. All rights reserved.
//

#import "HotActivityCell.h"
#import "RecommendModel.h"

@interface HotActivityCell ()
{
    UIImageView *_imageView;
    UILabel *_categoryLabel;
    UILabel *_titleLabel;
    UILabel *_contentLabel;
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

+(CGFloat)getCellHeight:(RecommendModel *)model{
    return 150;
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
    _imageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_imageView];
    
    _categoryLabel = [[UILabel alloc] init];
    _categoryLabel.textColor = [UIColor lightGrayColor];
    _categoryLabel.backgroundColor = [UIColor clearColor];
    _categoryLabel.font = [UIFont systemFontOfSize:14.f];
    [self.contentView addSubview:_categoryLabel];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.numberOfLines = 0;
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.font = [UIFont boldSystemFontOfSize:18.f];
    [self.contentView addSubview:_titleLabel];
    
    
    
    UIView *lineView = [[UIView alloc] init];
    lineView.frame = CGRectMake(0, 149, SCREEN_WIDTH, 0.7);
    lineView.backgroundColor = [AppTools colorWithHexString:@"#F0F0F0"];
    [self.contentView addSubview:lineView];

}


-(void)setttingViewAtuoLayout{
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 120));
        make.top.mas_equalTo(@(HMStatusCellMargin));
        make.left.mas_equalTo(@(10));
    }];
    
    [_categoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageView);
        make.left.equalTo(_imageView.mas_right).offset(HMStatusCellMargin);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-HMStatusCellMargin); // 设置titleLabel右边与父控件的偏移量
        make.height.mas_equalTo(@(20));
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.
    }]
}








-(void)setModel:(RecommendModel *)model{
    _model = model;
    

    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:nil];
    
    _categoryLabel.text = model.category_name;
    
}












@end
