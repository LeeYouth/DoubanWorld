//
//  LYCityHandler.m
//  DoubanWorlds
//
//  Created by LYoung on 15/12/25.
//  Copyright © 2015年 LYoung. All rights reserved.
//

#import "LYCityHandler.h"

@implementation LYCityHandler

+(NSString *)getCNCityNameWithSectionArr:(NSArray *)sectionArr cityDict:(NSDictionary *)cityDict indexPath:(NSIndexPath *)indexPath{
    NSString *key = [sectionArr objectAtIndex:indexPath.section - 2];
    NSArray *array = [cityDict valueForKey:key];
    
    NSDictionary *dict = [array objectAtIndex:indexPath.row];
    NSEnumerator * enumeratorKey = [dict keyEnumerator];
    NSString *objKey;
    while((objKey = [enumeratorKey nextObject]))
    {
        //        NSLog(@"遍历的值: %@",objKey);
        return objKey;
        break;
    }
    return objKey;
}

+(NSString *)getCityNameWithSectionArr:(NSArray *)sectionArr cityDict:(NSDictionary *)cityDict indexPath:(NSIndexPath *)indexPath{
    NSString *key = [sectionArr objectAtIndex:indexPath.section];
    NSArray *array = [cityDict valueForKey:key];
    
    NSDictionary *dict = [array objectAtIndex:indexPath.row];
    NSEnumerator * enumeratorKey = [dict keyEnumerator];
    NSString *objKey;
    while((objKey = [enumeratorKey nextObject]))
    {
//        NSLog(@"遍历的值: %@",objKey);
        return objKey;
        break;
    }
    return objKey;
}
+(NSString *)getCNCityIDWithSectionArr:(NSArray *)sectionArr cityDict:(NSDictionary *)cityDict indexPath:(NSIndexPath *)indexPath{
    NSString *key = [sectionArr objectAtIndex:indexPath.section - 2];
    NSArray *array = [cityDict valueForKey:key];
    
    NSDictionary *dict = [array objectAtIndex:indexPath.row];
    NSEnumerator * enumeratorKey = [dict keyEnumerator];
    
    NSString *value;
    while((value = [enumeratorKey nextObject]))
    {
        return [dict objectForKey:value];
        break;
        //        NSLog(@"遍历的值: %@",value);
    }
    
    return [dict objectForKey:value];
}
+(NSString *)getCityIDWithSectionArr:(NSArray *)sectionArr cityDict:(NSDictionary *)cityDict indexPath:(NSIndexPath *)indexPath{
    NSString *key = [sectionArr objectAtIndex:indexPath.section];
    NSArray *array = [cityDict valueForKey:key];
    
    NSDictionary *dict = [array objectAtIndex:indexPath.row];
    NSEnumerator * enumeratorKey = [dict keyEnumerator];
    
    NSString *value;
    while((value = [enumeratorKey nextObject]))
    {
        return [dict objectForKey:value];
        break;
//        NSLog(@"遍历的值: %@",value);
    }
    
    return [dict objectForKey:value];
}

+(NSInteger)getOneSectionCountWithSectionArr:(NSArray *)sectionArr cityDict:(NSDictionary *)cityDict section:(NSInteger)section{
    NSString *key = [sectionArr objectAtIndex:section];
    NSArray *array = [cityDict valueForKey:key];
    return array.count;
}

+(NSString *)getCityNameByUID:(NSString *)cityID{
    NSString *allCityName = [[NSBundle mainBundle] pathForResource:@"AllCityName" ofType:@""];
    NSError *error = nil;
    NSString *name = [[NSString alloc] initWithContentsOfFile:allCityName encoding:NSUTF8StringEncoding error:&error];
    
    NSString *allcityID = [[NSBundle mainBundle] pathForResource:@"AllCityID" ofType:@""];
    NSString *ID = [[NSString alloc] initWithContentsOfFile:allcityID encoding:NSUTF8StringEncoding error:&error];

    int arrayIndex = -1;
    NSArray *cityNameArray = [name componentsSeparatedByString:@"city="];
    NSArray *cityUIDArray = [ID componentsSeparatedByString:@"uid="];

    for (int i = 0; i < [cityUIDArray count]; i++) {
        if ([cityUIDArray[i] compare:cityID options:NSCaseInsensitiveSearch] == 0) {
            arrayIndex = i;
            break;
        }
    }
    if (arrayIndex == -1) {
        return @"不能发现城市";
    }
    return cityNameArray[arrayIndex];
}

//通过城市名字，返回城市对应的ID
+ (NSString *)getCityIDByName:(NSString *)cityName
{
    NSString *allCityName = [[NSBundle mainBundle] pathForResource:@"AllCityName" ofType:@""];
    NSError *error = nil;
    NSString *name = [[NSString alloc] initWithContentsOfFile:allCityName encoding:NSUTF8StringEncoding error:&error];
    
    NSString *allcityID = [[NSBundle mainBundle] pathForResource:@"AllCityID" ofType:@""];
    NSString *ID = [[NSString alloc] initWithContentsOfFile:allcityID encoding:NSUTF8StringEncoding error:&error];
    
    int cityID = -1;
    NSArray *cityNameArray = [name componentsSeparatedByString:@"city="];
    NSArray *cityIDArray = [ID componentsSeparatedByString:@"uid="];
    //通过城市名查找城市对应ID号
    for (int i = 0; i < [cityNameArray count]; i++) {
        if ([cityNameArray[i] isEqualToString:cityName]) {
            cityID = i;
            break;
        }
    }
    //如果不能发现城市ID，返回错误提示信息
    if (cityID == -1) {
        return @"不能发现城市ID,请检查输入的城市名字";
    }
    //返回找到的正确的城市ID
    return cityIDArray[cityID];
}

+ (NSArray *)getAllCityName{
    NSString *allCityName = [[NSBundle mainBundle] pathForResource:@"AllCityName" ofType:@""];
    NSError *error = nil;
    NSString *name = [[NSString alloc] initWithContentsOfFile:allCityName encoding:NSUTF8StringEncoding error:&error];
    NSArray *cityNameArray = [name componentsSeparatedByString:@"city="];
    return cityNameArray;
}

@end
