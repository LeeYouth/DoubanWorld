//
//  DetialSecondCell.h
//  DoubanWorlds
//
//  Created by LYoung on 15/12/30.
//  Copyright © 2015年 LYoung. All rights reserved.
//  活动详情页第二个cell

#import <UIKit/UIKit.h>
@class RecommendModel;

@interface DetialSecondCell : UITableViewCell

@property (nonatomic ,strong) RecommendModel *model;

+(CGFloat)getCellHeight;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic ,copy) NSString *title;
@property (nonatomic ,assign) BOOL isHidden;

@end
