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

/** 登录状态 */
@property (nonatomic ,strong) NSString *logType;
/**  */
@property (nonatomic ,strong) NSString *alt;
/** 头像小图 */
@property (nonatomic ,strong) NSString *avatar;
/** 注册时间 */
@property (nonatomic ,strong) NSString *created;
/** 描述 */
@property (nonatomic ,strong) NSString *desc;
/**  */
@property (nonatomic ,strong) NSString *is_banned;
/**  */
@property (nonatomic ,strong) NSString *is_suicide;
/** 头像大图 */
@property (nonatomic ,strong) NSString *large_avatar;
/** 所在城市ID */
@property (nonatomic ,strong) NSString *loc_id;
/** 所在地全称 */
@property (nonatomic ,strong) NSString *loc_name;
/** 昵称 */
@property (nonatomic ,strong) NSString *name;
/**  */
@property (nonatomic ,strong) NSString *signature;
/** 用户类型 */
@property (nonatomic ,strong) NSString *type;
/** 用户ID */
@property (nonatomic ,strong) NSString *uid;

@end
