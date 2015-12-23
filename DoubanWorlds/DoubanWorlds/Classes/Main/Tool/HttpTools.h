//
//  HttpTools.h
//  Finance
//
//  Created by LYoung on 15/8/4.
//  Copyright (c) 2015年 LYoung. All rights reserved.
//  基础网络请求

#import <Foundation/Foundation.h>


typedef void (^HttpSuccess)(id json);
typedef void (^HttpFailure)(NSError *error);

typedef void (^ArrayBlock)(NSMutableArray *resultArray);


@interface HttpTools : NSObject


/**
 *  POST请求
 */
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(HttpSuccess)success failure:(HttpFailure)failure;
/**
 *  GET请求
 */
+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(HttpSuccess)success failure:(HttpFailure)failure;

@end
