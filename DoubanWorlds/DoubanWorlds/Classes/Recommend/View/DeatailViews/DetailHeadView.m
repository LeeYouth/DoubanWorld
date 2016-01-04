//
//  DetailHeadView.m
//  DoubanWorlds
//
//  Created by LYoung on 15/12/30.
//  Copyright © 2015年 LYoung. All rights reserved.
//

#import "DetailHeadView.h"
#import "RecommendModel.h"
#import "ZLPhotoPickerBrowserViewController.h"

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
        _headImageView.userInteractionEnabled = YES;
        [self addSubview:_headImageView];
        
        [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(160, 220));
            make.center.equalTo(self);
        }];
        
        
        UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showHeadPortrait)];
        [_headImageView addGestureRecognizer:tapG];
        
        
    }
    return self;
}


-(void)setActivityModel:(RecommendModel *)activityModel{
    _activityModel = activityModel;
    
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:activityModel.image_hlarge] placeholderImage:[UIImage imageNamed:@"worlds_placeholderImage.jpg"]];
}


#pragma mark 传入imageView放大
- (void)showHeadPortrait{
    ZLPhotoPickerBrowserViewController *browserVc = [[ZLPhotoPickerBrowserViewController alloc] init];
    [browserVc showHeadPortrait:_headImageView originUrl:_activityModel.image_hlarge];
}



@end
