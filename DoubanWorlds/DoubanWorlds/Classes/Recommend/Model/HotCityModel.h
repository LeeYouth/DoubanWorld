//
//  HotCityModel.h
//  DoubanWorlds
//
//  Created by LYoung on 15/12/25.
//  Copyright © 2015年 LYoung. All rights reserved.
//  热门城市数据模型

#import <Foundation/Foundation.h>

@interface HotCityModel : NSObject
/** 父城市 */
@property (nonatomic ,strong) NSString *parent;
/** YES 或者 NO */
@property (nonatomic ,strong) NSString *habitable;
/** 城市ID */
@property (nonatomic ,strong) NSString *ID;
/** 城市名字 */
@property (nonatomic ,strong) NSString *name;
/** 城市英文名 */
@property (nonatomic ,strong) NSString *uid;

- (id)initWithDictionary:(NSDictionary *)dic;

@end
