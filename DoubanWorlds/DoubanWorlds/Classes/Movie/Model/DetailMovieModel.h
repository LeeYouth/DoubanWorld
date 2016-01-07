//
//  DetailMovieModel.h
//  DoubanWorlds
//
//  Created by LYoung on 16/1/7.
//  Copyright © 2016年 LYoung. All rights reserved.
//  详情页电影模型

#import <Foundation/Foundation.h>
@class RatingModel,CastModel,AvatarsModel;

@interface DetailMovieModel : NSObject

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

@property (nonatomic ,strong) NSString *ratings_count;
@property (nonatomic ,strong) NSString *comments_count;
@property (nonatomic ,strong) NSString *reviews_count;
@property (nonatomic ,strong) NSString *wish_count;
/** 豆瓣此电影主页 */
@property (nonatomic ,strong) NSString *douban_site;
/** 手机URL */
@property (nonatomic ,strong) NSString *mobile_url;
/** 分享地址URL */
@property (nonatomic ,strong) NSString *share_url;
/** 购票地址URL */
@property (nonatomic ,strong) NSString *schedule_url;
/** 所属国家 */
@property (nonatomic ,strong) NSMutableArray *countries;
/** 电影简介 */
@property (nonatomic ,strong) NSString *summary;
@property (nonatomic ,strong) NSMutableArray *aka;


- (id)initWithDictionary:(NSDictionary *)dic;

@end
