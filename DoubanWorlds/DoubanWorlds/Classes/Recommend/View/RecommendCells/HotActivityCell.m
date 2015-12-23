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
        
    }
    return self;
}

-(void)initUI{
    _imageView = [[UIImageView alloc] init];
    [self addSubview:_imageView];
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 120));
        make.top.mas_equalTo(@(HMStatusCellMargin));
        make.left.mas_equalTo(@(10));
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.frame = CGRectMake(0, 149, SCREEN_WIDTH, 0.7);
    lineView.backgroundColor = [AppTools colorWithHexString:@"#F0F0F0"];
    [self.contentView addSubview:lineView];

}









-(void)setModel:(RecommendModel *)model{
    _model = model;
    

    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:nil];
    
}












@end
