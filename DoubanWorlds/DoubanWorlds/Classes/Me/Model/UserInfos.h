//
//  UserInfos.h
//  DoubanWorlds
//
//  Created by LYoung on 16/1/4.
//  Copyright © 2016年 LYoung. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    LoginType = 0,
    LoginOutType
} LoginStatusType;


@interface UserInfos : NSObject

+(UserInfos *)sharedUserInfo;//单例
-(void)saveData;//用户信息保存本地
+(instancetype)userWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic ,strong) NSString *logType;
@property (nonatomic ,strong) NSString *alt;
@property (nonatomic ,strong) NSString *avatar;
@property (nonatomic ,strong) NSString *created;
@property (nonatomic ,strong) NSString *desc;
@property (nonatomic ,strong) NSString *is_banned;
@property (nonatomic ,strong) NSString *is_suicide;
@property (nonatomic ,strong) NSString *large_avatar;
@property (nonatomic ,strong) NSString *loc_id;
@property (nonatomic ,strong) NSString *loc_name;
@property (nonatomic ,strong) NSString *name;
@property (nonatomic ,strong) NSString *signature;
@property (nonatomic ,strong) NSString *type;
@property (nonatomic ,strong) NSString *uid;

@end
