//
//  MovieDetailHeadView.h
//  DoubanWorlds
//
//  Created by LYoung on 16/1/7.
//  Copyright © 2016年 LYoung. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MovieModel,DetailMovieModel;

@interface MovieDetailHeadView : UIView

@property (nonatomic ,strong) MovieModel *model;

@property (nonatomic ,strong) DetailMovieModel *infoModel;

@end
