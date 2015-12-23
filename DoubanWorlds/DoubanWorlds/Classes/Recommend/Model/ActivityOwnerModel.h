//
//  ActivityOwnerModel.h
//  DoubanWorlds
//
//  Created by LYoung on 15/12/23.
//  Copyright © 2015年 LYoung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityOwnerModel : NSObject

@property (nonatomic ,strong) NSString *name;
@property (nonatomic ,strong) NSString *avatar;
@property (nonatomic ,strong) NSString *uid;
@property (nonatomic ,strong) NSString *alt;
@property (nonatomic ,strong) NSString *type;
@property (nonatomic ,strong) NSString *ID;
@property (nonatomic ,strong) NSString *large_avatar;
- (id)initWithDictionary:(NSDictionary *)dic;

@end
