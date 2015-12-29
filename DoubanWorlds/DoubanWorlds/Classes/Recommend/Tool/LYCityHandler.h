//
//  LYCityHandler.h
//  DoubanWorlds
//
//  Created by LYoung on 15/12/25.
//  Copyright © 2015年 LYoung. All rights reserved.
//  城市控制

#import <Foundation/Foundation.h>

@interface LYCityHandler : NSObject

/**
 *  获取中国city的名字
 *
 *  @param sectionArr 分区数组
 *  @param cityDict   每个分区对应城市字典
 *  @param indexPath  cell的indexPath
 *
 *  @return 返回cell对应城市
 */

+(NSString *)getCNCityNameWithSectionArr:(NSArray *)sectionArr cityDict:(NSDictionary *)cityDict indexPath:(NSIndexPath *)indexPath;

/**
 *  获取外国city的名字
 *
 *  @param sectionArr 分区数组
 *  @param cityDict   每个分区对应城市字典
 *  @param indexPath  cell的indexPath
 *
 *  @return 返回cell对应城市
 */
+(NSString *)getCityNameWithSectionArr:(NSArray *)sectionArr cityDict:(NSDictionary *)cityDict indexPath:(NSIndexPath *)indexPath;

/**
 *  获取中国city的ID
 *
 *  @param sectionArr 分区数组
 *  @param cityDict   每个分区对应城市字典
 *  @param indexPath  cell的indexPath
 *
 *  @return 返回cell对应ID
 */
+(NSString *)getCNCityIDWithSectionArr:(NSArray *)sectionArr cityDict:(NSDictionary *)cityDict indexPath:(NSIndexPath *)indexPath;

/**
 *  获取国外city的ID
 *
 *  @param sectionArr 分区数组
 *  @param cityDict   每个分区对应城市字典
 *  @param indexPath  cell的indexPath
 *
 *  @return 返回cell对应ID
 */
+(NSString *)getCityIDWithSectionArr:(NSArray *)sectionArr cityDict:(NSDictionary *)cityDict indexPath:(NSIndexPath *)indexPath;

/**
 *  获取某一分区的城市个数
 *
 *  @param sectionArr 分区数组
 *  @param cityDict   每个分区对应城市字典
 *  @param indexPath  cell的indexPath
 *
 *  @return 返回分区对应的城市个数
 */
+(NSInteger)getOneSectionCountWithSectionArr:(NSArray *)sectionArr cityDict:(NSDictionary *)cityDict section:(NSInteger)section;

+(NSString *)getCityNameByUID:(NSString *)cityID;

+(NSString *)getCityIDByName:(NSString *)cityName;

+(NSArray *)getAllCityName;

@end
