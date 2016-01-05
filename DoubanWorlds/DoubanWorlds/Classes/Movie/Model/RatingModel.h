//
//  RatingModel.h
//  DoubanWorlds
//
//  Created by LYoung on 16/1/5.
//  Copyright © 2016年 LYoung. All rights reserved.
//  电影评分

#import <Foundation/Foundation.h>

@interface RatingModel : NSObject
/** 最高评分 */
@property (nonatomic ,strong) NSString *max;

@property (nonatomic ,strong) NSString *average;

@property (nonatomic ,strong) NSString *stars;
/** 最低评分 */
@property (nonatomic ,strong) NSString *min;

- (id)initWithDictionary:(NSDictionary *)dic;

@end
