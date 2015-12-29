//
//  RecommendHttpTool.m
//  DoubanWorlds
//
//  Created by LYoung on 15/12/23.
//  Copyright © 2015年 LYoung. All rights reserved.
//

#import "RecommendHttpTool.h"
#import "RecommendModel.h"
#import "HotCityModel.h"

@implementation RecommendHttpTool

#pragma mark - 获取活动列表(get请求
+(void)getRecommendList:(NSInteger)startNum loc:(NSString *)loc arrayBlock:(ArrayBlock)arrayBlock{
    
    NSString *urlString = [NSString stringWithFormat:@"%@?start=%ld&loc=%@&count=10",Recommend_URL,startNum,loc];
    NSLog(@"RecommendListURL = %@",urlString);
    [HttpTools getWithURL:urlString params:nil success:^(id json) {
//        NSLog(@"getRecommendList = %@",json);
        NSMutableArray *resultArr = [[NSMutableArray alloc] init];
        if ([json[@"events"] isKindOfClass:[NSArray class]]) {
            NSArray *resArray = json[@"events"];
            for (NSDictionary *dict in resArray) {
                RecommendModel *model = [[RecommendModel alloc] initWithDictionary:dict];
                [resultArr addObject:model];
            }
        }
        if (arrayBlock) {
            arrayBlock(resultArr);
        }
    } failure:^(NSError *error) {
        [SVProgressHUDManager networkError];
    }];
}

+(void)getChinaCityInfo:(CityInfoBlock)cityInfoBlock{
    
    //1.所有分区对应的字典
    NSString *inlandPlistURL = [[NSBundle mainBundle] pathForResource:@"inLandCityGroup" ofType:@"plist"];
    NSDictionary *cityGroupDic = [[NSDictionary alloc] initWithContentsOfFile:inlandPlistURL];
    
    //2.所有分区
    NSArray *sections = [cityGroupDic allKeys];
    sections = [sections sortedArrayUsingSelector:@selector(compare:)]; // 对该数组里边的元素进行升序排序
    //3.所有城市
    NSArray *indexs = [cityGroupDic allValues];
    
    if (cityInfoBlock) {
        cityInfoBlock(cityGroupDic,sections,indexs);
    }
}

+(void)getOverseasCityInfo:(CityInfoBlock)cityInfoBlock{
    
    //1.所有分区对应的字典
    NSString *inlandPlistURL = [[NSBundle mainBundle] pathForResource:@"outLandCityGroup" ofType:@"plist"];
    NSDictionary *cityGroupDic = [[NSDictionary alloc] initWithContentsOfFile:inlandPlistURL];
    
    //2.所有分区
    NSArray *sections = [cityGroupDic allKeys];
    sections = [sections sortedArrayUsingSelector:@selector(compare:)]; // 对该数组里边的元素进行升序排序
    //3.所有城市
    NSArray *indexs = [cityGroupDic allValues];
    
    if (cityInfoBlock) {
        cityInfoBlock(cityGroupDic,sections,indexs);
    }
}

+(void)getHotCitiesInfo:(ArrayBlock)arrayBlock{
    NSLog(@"getHotCitiesInfoURL = %@",HotCities_URL);
    //1.所有分区对应的字典
    NSString *inlandPlistURL = [[NSBundle mainBundle] pathForResource:@"hotcityCode" ofType:@"plist"];
    NSArray *hotCityArr = [[NSArray alloc] initWithContentsOfFile:inlandPlistURL];
    NSMutableArray *resultArr = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in hotCityArr) {
        HotCityModel *model = [[HotCityModel alloc] initWithDictionary:dict];
        [resultArr addObject:model];
    }
    if (arrayBlock) {
        arrayBlock(resultArr);
    }
}



@end
