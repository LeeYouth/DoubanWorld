//
//  MovieModel.h
//  DoubanWorlds
//
//  Created by LYoung on 16/1/5.
//  Copyright © 2016年 LYoung. All rights reserved.
//  电影信息模型

#import <Foundation/Foundation.h>
@class RatingModel,CastModel,AvatarsModel;

@interface MovieModel : NSObject

/** 电影评分 */
@property (nonatomic ,strong) RatingModel *rating;
/** 评分人数 */
@property (nonatomic ,strong) NSString *collect_count;
/** 电影类型 */
@property (nonatomic ,strong) NSMutableArray *genres;
/** 演员 */
@property (nonatomic ,strong) NSMutableArray *casts;
/** 名字 */
@property (nonatomic ,strong) NSString *title;
/** 原始名字 */
@property (nonatomic ,strong) NSString *original_title;
/** 类型 */
@property (nonatomic ,strong) NSString *subtype;
/** 导演 */
@property (nonatomic ,strong) NSMutableArray *directors;
/** 年份 */
@property (nonatomic ,strong) NSString *year;
/** 图片 */
@property (nonatomic ,strong) AvatarsModel *images;
/** 电影地址 */
@property (nonatomic ,strong) NSString *alt;
/** 电影ID */
@property (nonatomic ,strong) NSString *ID;

- (id)initWithDictionary:(NSDictionary *)dic;

@end
