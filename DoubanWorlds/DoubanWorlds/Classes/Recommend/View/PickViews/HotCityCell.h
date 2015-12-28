//
//  HotCityCell.h
//  DoubanWorlds
//
//  Created by LYoung on 15/12/28.
//  Copyright © 2015年 LYoung. All rights reserved.
//  热门城市cell

#import <UIKit/UIKit.h>

@interface HotCityCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

+(CGFloat)getCellHeight;

@end
