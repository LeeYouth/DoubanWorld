//
//  UserInfos.m
//  DoubanWorlds
//
//  Created by LYoung on 16/1/4.
//  Copyright © 2016年 LYoung. All rights reserved.
//

#import "UserInfos.h"

@implementation UserInfos

static UserInfos * userInfo = nil;

+(UserInfos *)sharedUserInfo{
    @synchronized(self){
        if (nil == userInfo) {
            userInfo = [[UserInfos alloc] init];
            NSString* path = NSHomeDirectory();
            userInfo = [UserInfos sharedUserInfo];
            path = [path stringByAppendingPathComponent:@"Library/user.arc"];
            NSLog(@"---------------path%@",path);
            if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                UserInfos* localUser = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
                if ([localUser isKindOfClass:[UserInfos class]]) {
                    userInfo.uid = localUser.uid;
                    userInfo.name = localUser.name;
                    userInfo.alt = localUser.alt;
                    userInfo.avatar = localUser.avatar;
                    userInfo.created = localUser.created;
                    userInfo.desc = localUser.desc;
                    userInfo.is_banned = localUser.is_banned;
                    userInfo.is_suicide = localUser.is_suicide;
                    userInfo.large_avatar = localUser.large_avatar;
                    userInfo.loc_id = localUser.loc_id;
                    userInfo.loc_name = localUser.loc_name;
                    userInfo.type = localUser.type;
                    userInfo.signature = localUser.signature;
                    userInfo.logType = localUser.logType;
                }
            }
        }
    }
    return userInfo;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        
        self.logType = [aDecoder decodeObjectForKey:USER_status];
        self.alt = [aDecoder decodeObjectForKey:USER_alt];
        self.avatar = [aDecoder decodeObjectForKey:USER_avatar];
        self.desc = [aDecoder decodeObjectForKey:USER_desc];
        self.is_banned = [aDecoder decodeObjectForKey:USER_is_banned];
        self.is_suicide = [aDecoder decodeObjectForKey:USER_is_suicide];
        self.large_avatar = [aDecoder decodeObjectForKey:USER_large_avatar];
        self.loc_id = [aDecoder decodeObjectForKey:USER_loc_id];
        self.loc_name = [aDecoder decodeObjectForKey:USER_loc_name];
        self.name = [aDecoder decodeObjectForKey:USER_name];
        self.type = [aDecoder decodeObjectForKey:USER_type];
        self.uid = [aDecoder decodeObjectForKey:USER_uid];
        self.signature = [aDecoder decodeObjectForKey:USER_signature];
        self.created = [aDecoder decodeObjectForKey:USER_created];


    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:self.logType forKey:USER_status];
    [aCoder encodeObject:self.signature forKey:USER_signature];
    [aCoder encodeObject:self.alt forKey:USER_alt];
    [aCoder encodeObject:self.created forKey:USER_created];
    [aCoder encodeObject:self.avatar forKey:USER_avatar];
    [aCoder encodeObject:self.desc forKey:USER_desc];
    [aCoder encodeObject:self.is_banned forKey:USER_is_banned];
    [aCoder encodeObject:self.is_suicide forKey:USER_is_suicide];
    [aCoder encodeObject:self.large_avatar forKey:USER_large_avatar];
    [aCoder encodeObject:self.loc_id forKey:USER_loc_id];
    [aCoder encodeObject:self.loc_name forKey:USER_loc_name];
    [aCoder encodeObject:self.name forKey:USER_name];
    [aCoder encodeObject:self.type forKey:USER_type];
    [aCoder encodeObject:self.uid forKey:USER_uid];
    

}

- (instancetype)initWithDic:(NSDictionary *)dictionary {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    userInfo = self;
    return userInfo;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

+(instancetype)userWithDictionary:(NSDictionary *)dictionary {
    return [[self alloc] initWithDic:dictionary];
}


//个人信息保存到本地
-(void)saveData{
    NSString* path = NSHomeDirectory();
    path = [path stringByAppendingPathComponent:@"Library/user.arc"];
    if (userInfo) {
        [NSKeyedArchiver archiveRootObject:userInfo toFile:path];
    }
}


@end
