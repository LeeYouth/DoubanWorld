//
//  CityIndexCell.h
//  DoubanWorlds
//
//  Created by LYoung on 15/12/25.
//  Copyright © 2015年 LYoung. All rights reserved.
//  城市cell

#import <UIKit/UIKit.h>

@interface CityIndexCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

+(CGFloat)getCellHeight;


@property (nonatomic ,strong) NSString *cityName;


@end
