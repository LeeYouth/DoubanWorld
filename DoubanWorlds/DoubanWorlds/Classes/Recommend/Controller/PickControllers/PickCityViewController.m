//
//  PickCityViewController.m
//  DoubanWorlds
//
//  Created by LYoung on 15/12/25.
//  Copyright © 2015年 LYoung. All rights reserved.
//

#import "PickCityViewController.h"
#import "PickOverseasController.h"
#import "PickChinaCityController.h"
#import "LocationManager.h"


@interface PickCityViewController ()


@property (nonatomic, strong) PickChinaCityController *chinaVC;
@property (nonatomic, strong) PickOverseasController *overseasVC;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) NSMutableArray *viewControllers;
@property (nonatomic, strong) UIScrollView *backgroundScrollView;

@end

@implementation PickCityViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self loadSegmentedControl];
    
    [self loadControllers];
    
    [self loadScrollView];
    
    LocationManager *manager = [LocationManager sharedFOLClient];
    [manager currentLocation:^(CLLocation *currentLocation, NSString *cityName) {
        NSLog(@"-------------%@,,,,,,,%@",currentLocation,cityName);
    }];
}


- (void)loadSegmentedControl{
    self.view.backgroundColor = [UIColor whiteColor];

    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"国内",@"国外",nil];
    _segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    _segmentedControl.frame = CGRectMake(0,0,180,30);
    _segmentedControl.tintColor = TheThemeColor;
    [_segmentedControl setSelectedSegmentIndex:0];
    [_segmentedControl addTarget:self action:@selector(segmentedControlAction:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = _segmentedControl;
}

- (void)segmentedControlAction:(id)sender{
    NSInteger selectedIndex = [sender selectedSegmentIndex];
    
    [self.backgroundScrollView setContentOffset:CGPointMake(SCREEN_WIDTH*selectedIndex, 0) animated:NO];

}

-(void)loadControllers{
    
    _viewControllers = [[NSMutableArray alloc] init];
    
    _chinaVC = [[PickChinaCityController alloc] init];
    _overseasVC = [[PickOverseasController alloc] init];
    
    [self addChildViewController:_chinaVC];
    [self addChildViewController:_overseasVC];

    _viewControllers = [NSMutableArray arrayWithObjects:_chinaVC,_overseasVC,nil];
    
}

-(void)loadScrollView{
    
    NSInteger viewCounts = _viewControllers.count;
    
    //初始化最底部的scrollView,装tableView用
    self.backgroundScrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.backgroundScrollView.backgroundColor = [UIColor whiteColor];
    self.backgroundScrollView.pagingEnabled = YES;
    self.backgroundScrollView.bounces = NO;
    self.backgroundScrollView.showsHorizontalScrollIndicator = NO;
    self.backgroundScrollView.delegate = (id<UIScrollViewDelegate>)self;
    self.backgroundScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * viewCounts, 0);
    [self.view addSubview:self.backgroundScrollView];
    
    
    for (int i = 0; i < viewCounts; i++) {
        UIViewController *listCtrl = self.viewControllers[i];
        listCtrl.view.frame = CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self.backgroundScrollView addSubview:listCtrl.view];
    }
    
    [self.backgroundScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger pageIndex = (NSInteger)scrollView.contentOffset.x/SCREEN_WIDTH;
    [_segmentedControl setSelectedSegmentIndex:pageIndex];
}





@end
