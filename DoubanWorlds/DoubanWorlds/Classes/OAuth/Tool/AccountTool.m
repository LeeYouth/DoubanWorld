//
//  AccountTool.m
//  DoubanWorlds
//
//  Created by LYoung on 16/1/4.
//  Copyright © 2016年 LYoung. All rights reserved.
//

#import "AccountTool.h"
#import "LYAccount.h"

#define YLYAccountPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]


@implementation AccountTool

/**
 *  全局变量至允许YLYAccountTool.m直接访问
 */
static LYAccount *_currenAccount;

+(void)saveAccount:(LYAccount *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:YLYAccountPath];
}
+(LYAccount *)currenAccount
{
    if (_currenAccount==nil) {//减少IO操作
        _currenAccount = [NSKeyedUnarchiver unarchiveObjectWithFile:YLYAccountPath];
    }
    return _currenAccount;
}

+(void)getAccessTokenWithcode:(NSString *)code success:(AccessTokenSuccess)success filure:(HttpFailure)failure
{
    //1.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"client_id"] = APIKey;
    params[@"client_secret"] = APISecret;
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = Redirect_uri;
    //2.发送请求
    [HttpTools postWithURL:Access_TokenUrl params:params success:^(id jsonDic){
        
        NSLog(@"access_Token成功!返回= %@",jsonDic);
        
        //2.1存储access_Token
        LYAccount *account = [[LYAccount alloc] initWithDict:jsonDic];
        
        //2.2存储账号模型对象
        [AccountTool saveAccount:account];
        
        //2.3通知外界获取accessToken成功
        if (success) {
            success();
        }
        
    } failure:failure];
    
}


@end
