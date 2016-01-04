//
//  MeHttpTool.m
//  DoubanWorlds
//
//  Created by LYoung on 16/1/4.
//  Copyright © 2016年 LYoung. All rights reserved.
//

#import "MeHttpTool.h"
#import "UserInfos.h"
#import "LYAccount.h"
#import "AccountTool.h"

@implementation MeHttpTool

+ (void)userInfoSuccess:(UserInfoSuccess)success{
    NSString *userID = [AccountTool currenAccount].douban_user_id;
    NSString *url = [NSString stringWithFormat:@"%@%@",UserInfo_URL,userID];
    [HttpTools getWithURL:url params:nil success:^(id json) {
        NSLog(@"resultDict = %@",json);
        if ([json isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dict = json;
            UserInfos *user = [UserInfos sharedUserInfo];
            user = [UserInfos userWithDictionary:dict];
            [user saveData];//保存到本地
            if (success) {
                success(user);
            }
        }
    } failure:^(NSError *error) {
        NSLog(@"resultDicterror = %@",error);
        [SVProgressHUDManager showErrorWithStatus:@"网络错误"];
    }];
}


@end
