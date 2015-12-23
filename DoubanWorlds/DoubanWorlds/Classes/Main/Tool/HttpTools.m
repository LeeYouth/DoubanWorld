//
//  HttpTools.m
//  Finance
//
//  Created by LYoung on 15/8/4.
//  Copyright (c) 2015年 LYoung. All rights reserved.
//

#import "HttpTools.h"
#import "AFNetworking.h"


@implementation HttpTools

#pragma mark - POST请求
+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(HttpSuccess)success failure:(HttpFailure)failure{
    //1.使用 NSURLConnection版本的AFNetworking
    //1.1创建一个AFN管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //1.2告诉manager只下载原始数据, 不要解析数据(一定要写)
    //AFN即可以下载网络数据, 又可以解析json数据,如果不写下面的  自动就解析json
    //由于做服务器的人返回json数据往往不规范, 凡是AFN又检查很严格,导致json解析往往失败
    //下面这句话的意思是 告诉AFN千万别解析, 只需要给我裸数据就可以
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = operation.responseData;
        NSDictionary *dict = [NSJSONSerialization  JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (success) {
            success(dict);
        }
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - GET请求
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(HttpSuccess)success failure:(HttpFailure)failure{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = operation.responseData;
        id dict = [NSJSONSerialization  JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (success) {
            success(dict);
        }
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


@end
