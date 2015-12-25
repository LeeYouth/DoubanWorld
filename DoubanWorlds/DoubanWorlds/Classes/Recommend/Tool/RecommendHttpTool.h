//
//  RecommendHttpTool.h
//  DoubanWorlds
//
//  Created by LYoung on 15/12/23.
//  Copyright © 2015年 LYoung. All rights reserved.
//  推荐网络请求封装

#import <Foundation/Foundation.h>

typedef void (^CityInfoBlock)(NSDictionary *resDict,NSArray *firstArray,NSArray *secondArray);

@interface RecommendHttpTool : NSObject

/**
*  获取活动列表(get请求
*
*  @param startNum 请求页数
*  @param loc      地区信息
*/
+(void)getRecommendList:(NSInteger)startNum loc:(NSString *)loc arrayBlock:(ArrayBlock)arrayBlock;


/**
 *  获取中国城市信息
 *
 *  @param cityInfoBlock 从本地获取的城市信息
 */
+(void)getChinaCityInfo:(CityInfoBlock)cityInfoBlock;


/**
 *  获取国外城市信息
 *
 *  @param cityInfoBlock 从本地获取的城市信息
 */
+(void)getOverseasCityInfo:(CityInfoBlock)cityInfoBlock;


@end
