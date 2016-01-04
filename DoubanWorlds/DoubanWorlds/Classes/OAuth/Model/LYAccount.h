//
//  LYAccount.h
//  DoubanWorlds
//
//  Created by LYoung on 16/1/4.
//  Copyright © 2016年 LYoung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYAccount : NSObject

/**  string 用于调用access_token,接口获取授权后的access token */
@property (nonatomic,copy) NSString *access_token;

/**  string 用于调用access_token 生命周期,单位是秒数 */
@property (nonatomic,copy) NSString *expires_in;


@property (nonatomic ,strong) NSString *refresh_token;

/**  string 授权用户的UID */
@property (nonatomic,copy) NSString *douban_user_id;
- (id)initWithDict:(NSDictionary *)dic;

@end
