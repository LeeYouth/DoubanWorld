//
//  LocationManager.h
//  DoubanWorlds
//
//  Created by LYoung on 15/12/28.
//  Copyright © 2015年 LYoung. All rights reserved.
//  当前位置管理

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void (^LocationBlock)(CLLocation *currentLocation,NSString *cityName);

@interface LocationManager : NSObject

+ (LocationManager *)sharedFOLClient;

/**
 *  获取地址
 *
 *  @param addressBlock addressBlock description
 */
- (void) getAddress:(LocationBlock)locationBlock;

@end
