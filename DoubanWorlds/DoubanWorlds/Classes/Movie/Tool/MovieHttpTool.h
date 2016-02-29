//
//  MovieHttpTool.h
//  DoubanWorlds
//
//  Created by LYoung on 16/1/5.
//  Copyright © 2016年 LYoung. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DetailMovieModel;

typedef void (^MovieInfoBlock)(DetailMovieModel *movieModel);

@interface MovieHttpTool : NSObject
/**
 *  获取热映电影
 *
 *  @param start      开始页
 *  @param arrayBlock 返回数组
 */
+(void)getHotMovieWithStart:(NSInteger)start arrayBlock:(ArrayBlock)arrayBlock;

/**
 *  即将上映的电影
 *
 *  @param start      开始页
 *  @param arrayBlock 返回数组
 */
+(void)getComingsoonWithStart:(NSInteger)start arrayBlock:(ArrayBlock)arrayBlock;

/**
 *  电影详细信息
 *
 *  @param movieID 电影ID
 */
+(void)getMovieInfoWithID:(NSString *)movieID movieInfoBlock:(MovieInfoBlock)movieInfoBlock;

@end
