//
//  RatingModel.m
//  DoubanWorlds
//
//  Created by LYoung on 16/1/5.
//  Copyright © 2016年 LYoung. All rights reserved.
//

#import "RatingModel.h"

@implementation RatingModel

- (id)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
        
        self.max = [NSString stringWithFormat:@"%@",dic[@"max"]];
        self.average = [NSString stringWithFormat:@"%@",dic[@"average"]];
        self.stars = [NSString stringWithFormat:@"%@",dic[@"stars"]];
        self.min = [NSString stringWithFormat:@"%@",dic[@"min"]];
        
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
