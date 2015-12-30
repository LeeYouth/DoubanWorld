//
//  DetailFirstRowCell.h
//  DoubanWorlds
//
//  Created by LYoung on 15/12/30.
//  Copyright © 2015年 LYoung. All rights reserved.
//  活动详情页第一个cell

#import <UIKit/UIKit.h>
@class RecommendModel;

@interface DetailFirstRowCell : UITableViewCell

@property (nonatomic ,strong) RecommendModel *model;

+(CGFloat)getCellHeight:(RecommendModel *)model;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
