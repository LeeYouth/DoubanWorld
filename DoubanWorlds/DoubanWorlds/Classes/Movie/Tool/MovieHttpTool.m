//
//  MovieHttpTool.m
//  DoubanWorlds
//
//  Created by LYoung on 16/1/5.
//  Copyright © 2016年 LYoung. All rights reserved.
//

#import "MovieHttpTool.h"
#import "MovieModel.h"
#import "DetailMovieModel.h"

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
    } failure:^(NSError *error) {
        [SVProgressHUDManager showErrorWithStatus:@"网络出错啦"];
    }];
}

+(void)getComingsoonWithStart:(int)start arrayBlock:(ArrayBlock)arrayBlock{
    NSString *urlSting = [NSString stringWithFormat:@"%@?count=10&start=%d",ComingsoonMovie_URL,start];
    NSLog(@"ComingsoonMovie_URL = %@",urlSting);
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
    } failure:^(NSError *error) {
        [SVProgressHUDManager showErrorWithStatus:@"网络出错啦"];
    }];
}


+(void)getMovieInfoWithID:(NSString *)movieID movieInfoBlock:(MovieInfoBlock)movieInfoBlock{
    NSString *urlString = [NSString stringWithFormat:@"%@%@",MovieInfo_URL,movieID];
    NSLog(@"MovieInfo_URL = %@",urlString);
    [HttpTools getWithURL:urlString params:nil success:^(id json) {
        
        DetailMovieModel *model = [[DetailMovieModel alloc] init];
        if ([json isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dict = json;
            DetailMovieModel *m = [[DetailMovieModel alloc] initWithDictionary:dict];
            model = m;
        }
        movieInfoBlock(model);
        NSLog(@"MovieInfo_URL_resultDict = %@",json);
    } failure:^(NSError *error) {
        [SVProgressHUDManager showErrorWithStatus:@"网络出错啦"];
    }];

}


@end
