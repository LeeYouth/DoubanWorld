//
//  MovieHttpTool.m
//  DoubanWorlds
//
//  Created by LYoung on 16/1/5.
//  Copyright © 2016年 LYoung. All rights reserved.
//

#import "MovieHttpTool.h"
#import "MovieModel.h"

@implementation MovieHttpTool

+(void)getHotMovieWithStart:(int)start arrayBlock:(ArrayBlock)arrayBlock{
    
    NSString *urlSting = [NSString stringWithFormat:@"%@?count=10&start=%d",HotMovie_URL,start];
    NSLog(@"HotMovie_URL = %@",urlSting);
    [HttpTools getWithURL:urlSting params:nil success:^(id json) {
        NSMutableArray *resArray = [[NSMutableArray alloc] init];
        if ([json[@"subjects"] isKindOfClass:[NSArray class]]) {
            NSArray *subjectsArr = json[@"subjects"];
            for (NSDictionary *dict in subjectsArr) {
                MovieModel *movieM = [[MovieModel alloc] initWithDictionary:dict];
                [resArray addObject:movieM];
            }
        }
        if (arrayBlock) {
            arrayBlock(resArray);
        }
        NSLog(@"HotMovie_resultDict = %@",json);
    } failure:^(NSError *error) {
        [SVProgressHUDManager showErrorWithStatus:@"网络出错啦"];
    }];
}


@end
