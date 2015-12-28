//
//  LocationManager.h
//  DoubanWorlds
//
//  Created by LYoung on 15/12/28.
//  Copyright © 2015年 LYoung. All rights reserved.
//  当前位置管理

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol LocationManagerDelegate <NSObject>

@optional
-(void)currentCityName:(NSString *)cityName cityID:(NSString *)cityID;

@end

@interface LocationManager : NSObject<CLLocationManagerDelegate>

@property (nonatomic ,strong) CLLocationManager  *locationManager;

- (void)currentLocation;

@property (nonatomic ,assign) id<LocationManagerDelegate>delegate;

@end
