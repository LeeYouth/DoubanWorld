//
//  MapViewController.h
//  DoubanWorlds
//
//  Created by LYoung on 15/12/30.
//  Copyright © 2015年 LYoung. All rights reserved.
//  位置定位界面

#import "BaseViewController.h"

@interface MapViewController : BaseViewController

@property (nonatomic ,copy) NSString *activityName;

@property (nonatomic ,copy) NSString *address;

@property (nonatomic ,strong) NSString *geo;


@end
