//
//  LYAccount.m
//  DoubanWorlds
//
//  Created by LYoung on 16/1/4.
//  Copyright © 2016年 LYoung. All rights reserved.
//

#import "LYAccount.h"

@implementation LYAccount
/**
 *  从文件解析对象的时候调用
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if(self = [super init])
    {
        _access_token = [decoder decodeObjectForKey:@"_access_token"];
        _expires_in = [decoder decodeObjectForKey:@"_expires_in"];
        _refresh_token = [decoder decodeObjectForKey:@"_refresh_token"];
        _douban_user_id = [decoder decodeObjectForKey:@"_douban_user_id"];
    }
    return self;
}
/**
 *  将对象 写入 文件时调用
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:_access_token forKey:@"_access_token"];
    [encoder encodeObject:_expires_in forKey:@"_expires_in"];
    [encoder encodeObject:_refresh_token forKey:@"_refresh_token"];
    [encoder encodeObject:_douban_user_id forKey:@"_douban_user_id"];
    
}

- (id)initWithDict:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.access_token = dic[@"access_token"];
        self.expires_in = dic[@"expires_in"];
        self.refresh_token = dic[@"refresh_token"];
        self.douban_user_id = dic[@"douban_user_id"];
    }
    return self;
}
@end
