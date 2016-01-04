//
//  MeHttpTool.h
//  DoubanWorlds
//
//  Created by LYoung on 16/1/4.
//  Copyright © 2016年 LYoung. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserInfos;

@interface MeHttpTool : NSObject
//block传值
typedef void (^UserInfoSuccess)(UserInfos *user);


+ (void)userInfoSuccess:(UserInfoSuccess)success;

@end
