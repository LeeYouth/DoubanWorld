//
//  RecommendHttpTool.m
//  DoubanWorlds
//
//  Created by LYoung on 15/12/23.
//  Copyright © 2015年 LYoung. All rights reserved.
//

#import "RecommendHttpTool.h"
#import "RecommendModel.h"

@implementation RecommendHttpTool

#pragma mark - 获取活动列表(get请求
+(void)getRecommendList:(NSInteger)startNum loc:(NSString *)loc arrayBlock:(ArrayBlock)arrayBlock{
    
    NSString *urlString = [NSString stringWithFormat:@"%@?start=%ld&loc=%@&count=10",Recommend_URL,startNum,loc];
    [HttpTools getWithURL:urlString params:nil success:^(id json) {
        NSLog(@"getRecommendList = %@",json);
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

@end
