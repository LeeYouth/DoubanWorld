//
//  RecommendModel.m
//  DoubanWorlds
//
//  Created by LYoung on 15/12/23.
//  Copyright © 2015年 LYoung. All rights reserved.
//

#import "RecommendModel.h"
#import "ActivityOwnerModel.h"

@implementation RecommendModel
- (id)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
        if (dic[@"id"]) {
            self.ID = [NSString stringWithFormat:@"%@",dic[@"id"]];
            if (dic[@"owner"]) {
                self.owner = [[ActivityOwnerModel alloc] initWithDictionary:dic[@"owner"]];
            }
        }
    }
    return self;
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

-(id)valueForKeyPath:(NSString *)keyPath
{
    return nil;
}
@end
