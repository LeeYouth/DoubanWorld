//
//  HotMovieCell.h
//  DoubanWorlds
//
//  Created by LYoung on 16/1/5.
//  Copyright © 2016年 LYoung. All rights reserved.
//  热映电影

#import <UIKit/UIKit.h>
@class MovieModel;

@interface HotMovieCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

+(CGFloat)getCellHeight:(MovieModel *)model;

@property (nonatomic ,strong) MovieModel *model;

@end
