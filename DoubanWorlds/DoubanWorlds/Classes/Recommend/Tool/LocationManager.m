//
//  LocationManager.m
//  DoubanWorlds
//
//  Created by LYoung on 15/12/28.
//  Copyright © 2015年 LYoung. All rights reserved.
//

#import "LocationManager.h"
#import "LYCityHandler.h"

@implementation LocationManager



- (void)currentLocation{
    _locationManager = [[CLLocationManager alloc]init];
    _locationManager.delegate = self;
    [_locationManager requestAlwaysAuthorization];
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    if(iOS8)
    {
        [_locationManager requestWhenInUseAuthorization];
    }
    [_locationManager startUpdatingLocation];

}


- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status) {
        case kCLAuthorizationStatusDenied :
        {
            // 提示用户出错原因，可按住Option键点击 KCLErrorDenied的查看更多出错信息，可打印error.code值查找原因所在
            UIAlertView *tempA = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"请在设置-隐私-定位服务中开启定位功能！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [tempA show];
        }
            break;
        case kCLAuthorizationStatusNotDetermined :
            // Note: Xcode6才有的方法，所以会有警告
            if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
            {
                NSLog(@"调用");
                [self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)];
            }
            break;
        case kCLAuthorizationStatusRestricted:
        {
            // 提示用户出错原因，可按住Option键点击 KCLErrorDenied的查看更多出错信息，可打印error.code值查找原因所在
            [SVProgressHUDManager showErrorWithStatus:@"定位服务无法使用！"];
            
        }
        default:
            
            break;
    }
}
//获得当前位置的经纬度,和当期城市信息
- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    NSLog(@"location x = %f,y = %f",location.coordinate.latitude,location.coordinate.longitude);
    CLGeocoder *gecoder = [[CLGeocoder alloc] init];
    [gecoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placeMark = [placemarks objectAtIndex:0];
        NSLog(@"placeMark = %@",placeMark);
        if (placeMark != nil) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:10];
            [dic setObject:placeMark forKey:@"placeMark"];
            [dic setObject:location forKey:@"location"];
            NSLog(@"dic = %@",dic);
            
            NSString *cityUID;
            CLPlacemark *placeMark  = [dic objectForKey:@"placeMark"];
            if (placeMark.locality == nil) {
                cityUID =  placeMark.administrativeArea;
            }else{
                cityUID = placeMark.locality;
            }
            
            
            NSString *cityName = [LYCityHandler getCityNameByUID:cityUID];
            if ([cityName isEqualToString:@"不能发现城市"]) {
                cityName = [cityUID stringByReplacingOccurrencesOfString:@"市" withString:@""];
            }
            
            if (self.delegate &&  [_delegate respondsToSelector:@selector(currentCityName:cityID:)]) {
                [_delegate currentCityName:cityName cityID:[dic objectForKey:@"location"]];
            }
            NSLog(@"cityName = %@,location = %@",cityName,_locationManager);
        }
    }];
}

@end
