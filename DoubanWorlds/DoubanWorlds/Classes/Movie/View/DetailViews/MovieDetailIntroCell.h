//
//  MovieDetailIntroCell.h
//  DoubanWorlds
//
//  Created by LYoung on 16/1/20.
//  Copyright © 2016年 LYoung. All rights reserved.
//  电影详情页电影简介

#import <UIKit/UIKit.h>
@class DetailMovieModel;

typedef void (^CellBlock)(NSIndexPath *indexPath);


@interface MovieDetailIntroCell : UITableViewCell

@property (nonatomic ,strong) UIButton *unfoldBtn;//展开按钮

@property (nonatomic, copy) CellBlock block;

@property (nonatomic, strong) NSIndexPath *indexPath;


+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)configCellWithModel:(DetailMovieModel *)model;

+ (CGFloat)heightWithModel:(DetailMovieModel *)model;


@end
