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

@end
