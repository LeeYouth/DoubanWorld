//
//  MapViewController.m
//  DoubanWorlds
//
//  Created by LYoung on 15/12/30.
//  Copyright © 2015年 LYoung. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "UIBarButtonItem+Extension.h"
#import "ALActionSheetView.h"

@interface MapViewController ()<MKMapViewDelegate>

@property(nonatomic, strong) MKMapView *mapView;

@property(nonatomic, strong) CLGeocoder *geocoder;

@end

@implementation MapViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundColor:[UIColor whiteColor]];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self initUI];
    
    
    [self setupMapView];
    
    
    [self geocodeFromAddress];
    
}

-(void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"地图";
    
//    UIBarButtonItem *buttonItem = [UIBarButtonItem itemWithImage:@"nav_share" target:self action:@selector(openAction)];
//    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    negativeSpacer.width = -10;
//    self.navigationItem.rightBarButtonItems = @[negativeSpacer, buttonItem];
    //定位到的城市
    UIButton *navigation = [UIButton buttonWithType:UIButtonTypeCustom];
    [navigation setTitle:@"导航" forState:UIControlStateNormal];
    navigation.frame = CGRectMake(0, 0, 60, 40);
    [navigation setTitleColor:TheThemeColor forState:UIControlStateNormal];
    [navigation.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [navigation addTarget:self action:@selector(openAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:navigation];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -20;
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, buttonItem];
}

-(void)openAction{

    ALActionSheetView *actionSheetView = [ALActionSheetView showActionSheetWithTitle:@"" cancelButtonTitle:@"取消" destructiveButtonTitle:@"" otherButtonTitles: @[@"苹果地图"] handler:^(ALActionSheetView *actionSheetView, NSInteger buttonIndex) {
        NSLog(@"%zd", buttonIndex);
        if (buttonIndex == 0) {
            [self openSystemMapKit];
        }
    }];
    
    [actionSheetView show];

}

-(void)geocodeFromAddress{
    if ([NSString checkConvertNull:self.geo]) {
        [SVProgressHUDManager showErrorWithStatus:@"地理编码出错，或许你选的地方在冥王星"];
        return;
    }
    NSArray *coordinateArr = [[NSArray alloc] initWithArray:[self.geo componentsSeparatedByString:@" "]];
    double latitude = [coordinateArr[0] doubleValue];
    double longitude = [coordinateArr[1] doubleValue];

    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    
    [self addAnnotation:coordinate];

}


-(void)setupMapView{
    
    _geocoder=[[CLGeocoder alloc]init];

    _mapView = [[MKMapView alloc] init];
    //设置地图类型
    _mapView.mapType = MKMapTypeStandard;
    _mapView.delegate = self;
    
    _mapView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);

    [self.view addSubview:_mapView];
    
}

-(void)geocodeFromSystem{
    
    if (self.address.length == 0) {
        [SVProgressHUDManager showErrorWithStatus:@"位置错误"];
        return;
    }
    __weak MapViewController *weakSelf = self;
    
    [_geocoder geocodeAddressString:self.address completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error) {
            [SVProgressHUDManager showErrorWithStatus:@"地理编码出错，或许你选的地方在冥王星"];
            NSLog(@"%@", error);
            return;
        }
        
        CLPlacemark *placemark = [placemarks firstObject];
        //设定经纬度
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(placemark.location.coordinate.latitude, placemark.location.coordinate.longitude);
        
        [weakSelf addAnnotation:coordinate];
        
    }];
}




#pragma mark - 添加大头针
- (void)addAnnotation:(CLLocationCoordinate2D)coordinate {
    //显示尺寸span
    MKCoordinateSpan span = MKCoordinateSpanMake(0.04, 0.04);
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, span);

    [_mapView setRegion:region animated:YES];

    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.title = self.activityName;//标题
    annotation.subtitle = self.address;//副标题
    annotation.coordinate = coordinate;//经纬度（2D）
    

    [_mapView addAnnotation:annotation];

    [_mapView selectAnnotation:annotation animated:YES];//这样就可以在初始化的时候将 气泡信息弹出

}

#pragma mark - 在地图上定位
-(void)openSystemMapKit{
    if (iOS7) {
    NSArray *coordinateArr = [[NSArray alloc] initWithArray:[self.geo componentsSeparatedByString:@" "]];
    double latitude = [coordinateArr[0] doubleValue];
    double longitude = [coordinateArr[1] doubleValue];
    
    CLLocationCoordinate2D toCoordinate = CLLocationCoordinate2DMake(latitude, longitude);


    MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:toCoordinate addressDictionary:nil] ];
    toLocation.name = self.address;
    [MKMapItem openMapsWithItems:[NSArray arrayWithObjects:currentLocation, toLocation, nil]
                   launchOptions:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:MKLaunchOptionsDirectionsModeDriving, [NSNumber numberWithBool:YES], nil]
                                                             forKeys:[NSArray arrayWithObjects:MKLaunchOptionsDirectionsModeKey, MKLaunchOptionsShowsTrafficKey, nil]]];
    }else{
        [SVProgressHUDManager showErrorWithStatus:@"系统不支持打开地图"];
    }

}

@end
