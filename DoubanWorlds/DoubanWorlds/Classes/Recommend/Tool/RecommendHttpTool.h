//
//  RecommendHttpTool.h
//  DoubanWorlds
//
//  Created by LYoung on 15/12/23.
//  Copyright © 2015年 LYoung. All rights reserved.
//  推荐网络请求封装

#import <Foundation/Foundation.h>


@interface RecommendHttpTool : NSObject

/**
*  获取活动列表(get请求
*
*  @param startNum 请求页数
*  @param loc      地区信息
*/
+(void)getRecommendList:(NSInteger)startNum loc:(NSString *)loc arrayBlock:(ArrayBlock)arrayBlock;

@end
