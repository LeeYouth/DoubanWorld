//
//  MeHttpTool.m
//  DoubanWorlds
//
//  Created by LYoung on 16/1/4.
//  Copyright © 2016年 LYoung. All rights reserved.
//

#import "MeHttpTool.h"

@implementation MeHttpTool

+(void)getUserInfoWithID:(NSString *)userID{
    NSString *url = [NSString stringWithFormat:@"%@%@",UserInfo_URL,userID];
    [HttpTools getWithURL:url params:nil success:^(id json) {
        NSLog(@"resultDict = %@",json);
    } failure:^(NSError *error) {
        NSLog(@"resultDicterror = %@",error);
    }];
//    alt = "http://www.douban.com/people/102268725/";
//    avatar = "http://img4.douban.com/icon/user_normal.jpg";
//    created = "2014-09-25 20:46:19";
//    desc = "";
//    id = 102268725;
//    "is_banned" = 0;
//    "is_suicide" = 0;
//    "large_avatar" = "http://img3.douban.com/icon/user_large.jpg";
//    "loc_id" = 108288;
//    "loc_name" = "\U5317\U4eac";
//    name = "\U602a\U5496LYoung";
//    signature = "";
//    type = user;
//    uid = 102268725;
}


@end
