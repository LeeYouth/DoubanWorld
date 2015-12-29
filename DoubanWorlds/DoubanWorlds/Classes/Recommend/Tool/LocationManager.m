//
//  LocationManager.m
//  DoubanWorlds
//
//  Created by LYoung on 15/12/28.
//  Copyright © 2015年 LYoung. All rights reserved.
//

#import "LocationManager.h"
#import "LYCityHandler.h"

static LocationManager  *manager;

@interface LocationManager ()<CLLocationManagerDelegate>

@property (nonatomic, strong) LocationBlock locationBlock;
@property (strong, nonatomic) CLLocationManager  *locMgr;

@end

@implementation LocationManager

+ (LocationManager *)sharedFOLClient
{
    @synchronized(self){
        static dispatch_once_t pred;
        dispatch_once(&pred, ^{
            manager = [[self alloc] init];
        });
    }
    return manager;
}
-(instancetype)init{
    self = [super init];
    if (self) {
        
        [self initlocMgr];
    }
    return self;
}

- (void )initlocMgr {
    _locMgr = [[CLLocationManager alloc] init];
    _locMgr.delegate = self;
    // 定位精度
    _locMgr.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    // 距离过滤器，当移动距离小于这个值时不会收到回调
//    _locMgr.distanceFilter = 50;

}

- (void) currentLocation:(LocationBlock)locationBlock
{
    self.locationBlock = [locationBlock copy];
    [self locationAuthorizationJudge];
}

-(void)startLocating{
    [self locationAuthorizationJudge];
}

/**
 *  判断定位授权
 */
- (void)locationAuthorizationJudge {
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    NSString *locationServicesEnabled = [CLLocationManager locationServicesEnabled] ? @"YES" : @"NO";
    NSLog(@"location services enabled = %@", locationServicesEnabled);
    
    if (status == kCLAuthorizationStatusNotDetermined) { // 如果授权状态还没有被决定就弹出提示框
        if ([_locMgr respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [_locMgr requestWhenInUseAuthorization];
//            [_locMgr requestAlwaysAuthorization];
        }
        
         //也可以判断当前系统版本是否大于8.0
//        if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
//            [self.locMgr requestWhenInUseAuthorization];
//        }
    } else if (status == kCLAuthorizationStatusDenied) { // 如果授权状态是拒绝就给用户提示
        [SVProgressHUDManager showErrorWithStatus:@"请前往设置-隐私-定位中打开定位服务"];
    } else if (status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusAuthorizedAlways) { // 如果授权状态可以使用就开始获取用户位置
        [_locMgr startUpdatingLocation];
    }
}

/**
 *  只要定位到位置，就会调用，调用频率频繁
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *location = [locations lastObject];
    NSLog(@"我的位置是 - %@", location);
//    [self showInMapWithCoordinate:location.coordinate];
    // 根据不同需要停止更新位置
    [_locMgr stopUpdatingLocation];
    CLGeocoder *gecoder = [[CLGeocoder alloc] init];
    [gecoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placeMark = [placemarks objectAtIndex:0];
        if (placeMark != nil) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:10];
            [dic setObject:placeMark forKey:@"placeMark"];
            [dic setObject:location forKey:@"location"];
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
            
            CLLocation *currentLocation = [dic objectForKey:@"location"];
            if (_locationBlock) {
                _locationBlock(currentLocation,cityName);
            }
        }
    }];
    
}


@end
