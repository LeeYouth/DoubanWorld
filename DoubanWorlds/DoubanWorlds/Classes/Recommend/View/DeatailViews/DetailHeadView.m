//
//  DetailHeadView.m
//  DoubanWorlds
//
//  Created by LYoung on 15/12/30.
//  Copyright © 2015年 LYoung. All rights reserved.
//

#import "DetailHeadView.h"
#import "RecommendModel.h"

@interface DetailHeadView ()

{
    UIImageView *_headImageView;
}

@end

@implementation DetailHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _headImageView = [[UIImageView alloc] init];
        [self addSubview:_headImageView];
        
        [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(160, 220));
            make.center.equalTo(self);
        }];
        
        
    }
    return self;
}


-(void)setActivityModel:(RecommendModel *)activityModel{
    _activityModel = activityModel;
    
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:activityModel.image_hlarge] placeholderImage:[UIImage imageWithData:@"worlds_placeholderImage.jpg"]];
}


@end
