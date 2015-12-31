//
//  RecommendViewController.m
//  DoubanWorlds
//
//  Created by LYoung on 15/12/22.
//  Copyright © 2015年 LYoung. All rights reserved.
//

#import "RecommendViewController.h"
#import "LDRefresh.h"
#import "RecommendHttpTool.h"
#import "RecommendModel.h"
#import "HotActivityCell.h"
#import "PickCityViewController.h"
#import "LocationManager.h"
#import "LYCityHandler.h"
#import "ActivityDetailController.h"
#import "DXPopover.h"
#import "ActivityTypeView.h"

static CGFloat randomFloatBetweenLowAndHigh(CGFloat low, CGFloat high) {
    CGFloat diff = high - low;
    return (((CGFloat)rand() / RAND_MAX) * diff) + low;
}
@interface RecommendViewController ()
{
    NSInteger _startNum;
    UIButton *_locationBtn;
}

@property (nonatomic, copy) NSString *locID;//当前城市ID
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *resultArray;
@property (nonatomic, strong) DXPopover *popover;

@end

@implementation RecommendViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.resultArray = [NSMutableArray arrayWithCapacity:1];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _startNum = 0;
    
    [self initTableView];
    
    [self addRefreshView];
    
    [self initLeftButton];

    [self requestData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityButtonClick:) name:kCityButtonClick object:nil];
    
    [self setupNavTitleView];
    
}

- (void)initLeftButton{
    
    //定位到的城市
    _locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_locationBtn setTitle:@"北京" forState:UIControlStateNormal];
    [_locationBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_locationBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_locationBtn setImage:[UIImage imageNamed:@"LuckyMoney_ChangeArrow"] forState:UIControlStateNormal];
    [_locationBtn addTarget:self action:@selector(pushPickViewController) forControlEvents:UIControlEventTouchUpInside];
    _locationBtn.frame = CGRectMake(0, 0, 70, 40);
    [_locationBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 50, 0, 0)];
    [_locationBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:_locationBtn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -20;
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, buttonItem];

}

- (void)requestData{
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:kIsCityButtonClick]) {//是否点击选择了城市
        NSString *cName = [[NSUserDefaults standardUserDefaults] objectForKey:kCityButtonClick];
        NSString *ID = [LYCityHandler getCityIDByName:cName];
        self.locID = ID;
        [self refreshDataLocID:ID];
        
        [self setLeftBtnTitle:cName];

    }else{
        NSString *defaultsName = [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentLocation];

        if ([NSString checkConvertNull:defaultsName])//第一次登录
        {
            LocationManager *manager = [LocationManager sharedFOLClient];
            [manager currentLocation:^(CLLocation *currentLocation, NSString *cityName) {
                NSLog(@"currentLocation = %@,cityName = %@",currentLocation,cityName);
                
            }];
            
            NSString *cityName = @"北京";
            NSString *ID = [LYCityHandler getCityIDByName:cityName];
            NSLog(@"cityID = %@",ID);
            
            self.locID = [ID copy];
            [self refreshDataLocID:ID];
            
            [[NSUserDefaults standardUserDefaults] setObject:cityName forKey:kCurrentLocation];
            
            [self setLeftBtnTitle:cityName];

        }else
        {
            NSString *defaultsName = [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentLocation];
            NSString *ID = [LYCityHandler getCityIDByName:defaultsName];
            self.locID = [ID copy];
            [self refreshDataLocID:ID];
            
            LocationManager *manager = [LocationManager sharedFOLClient];
            __weak RecommendViewController *weekSelf = self;
            [manager currentLocation:^(CLLocation *currentLocation, NSString *cityName) {
                NSLog(@"currentLocation = %@,cityName = %@",currentLocation,cityName);
                if ([defaultsName isEqualToString:cityName])
                {
                    
                }else
                {
                    NSString *ID = [LYCityHandler getCityIDByName:cityName];
                    NSLog(@"cityID = %@",ID);
                    
                    weekSelf.locID = [ID copy];
                    [weekSelf refreshDataLocID:ID];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:cityName forKey:kCurrentLocation];
                }
                
            }];
            
            [self setLeftBtnTitle:[LYCityHandler getCityNameByUID:self.locID]];

        }
    }
}

#pragma mark - 设置左边按钮
- (void)setLeftBtnTitle:(NSString *)title{
    [_locationBtn setTitle:title forState:UIControlStateNormal];
    
}
#pragma mark - 城市按钮点击
- (void)cityButtonClick:(NSNotification *)note{
    NSString *cname = note.userInfo[kCityButtonClick];
    if (cname) {
        NSString *ID = [LYCityHandler getCityIDByName:cname];
        [_locationBtn setTitle:cname forState:UIControlStateNormal];

        self.locID = [ID copy];
        [self refreshDataLocID:ID];
        
        [[NSUserDefaults standardUserDefaults] setValue:cname forKey:kCityButtonClick];

        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kIsCityButtonClick];
    }
}


- (void)pushPickViewController{
    PickCityViewController *pickVC = [[PickCityViewController alloc] init];
    [self.navigationController pushViewController:pickVC animated:YES];
}

- (void)initTableView{
    self.view.backgroundColor = [UIColor whiteColor];

    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)])
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    _tableView                 = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 44)];
    _tableView.delegate        = (id<UITableViewDelegate>)self;
    _tableView.dataSource      = (id<UITableViewDataSource>) self;
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

- (void)addRefreshView {
    
    __weak __typeof(self) weakSelf = self;
    //下拉刷新
    _tableView.refreshHeader = [_tableView addRefreshHeaderWithHandler:^ {
        [weakSelf refreshDataLocID:weakSelf.locID];
    }];
}

- (void)refreshDataLocID:(NSString *)cityID {
    __weak __typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [RecommendHttpTool getRecommendList:_startNum loc:cityID arrayBlock:^(NSMutableArray *resultArray) {
            _resultArray = resultArray;
            [weakSelf.tableView reloadData];

        }];
        [weakSelf.tableView.refreshHeader endRefresh];
        
        weakSelf.tableView.refreshFooter.loadMoreEnabled = YES;
    });
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _resultArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    RecommendModel *model = [_resultArray objectAtIndex:indexPath.row];
    return [HotActivityCell getCellHeight:model];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RecommendModel *model = [_resultArray objectAtIndex:indexPath.row];

    HotActivityCell *activityCell = [HotActivityCell cellWithTableView:tableView];
    activityCell.model = model;
    return activityCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    RecommendModel *model = [_resultArray objectAtIndex:indexPath.row];

    ActivityDetailController *detailVC = [[ActivityDetailController alloc] init];
    detailVC.activityModel = model;
    [self.navigationController pushViewController:detailVC animated:YES];

}






-(void)setupNavTitleView{
    
    //定位到的城市
    UIButton *titleLb = [UIButton buttonWithType:UIButtonTypeCustom];
    [titleLb setTitle:@"热门" forState:UIControlStateNormal];
    [titleLb setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [titleLb.titleLabel setFont:[UIFont systemFontOfSize:15.f]];
    [titleLb setImage:[UIImage imageNamed:@"LuckyMoney_ChangeArrow"] forState:UIControlStateNormal];
    [titleLb addTarget:self action:@selector(titleShowPopover) forControlEvents:UIControlEventTouchUpInside];
    titleLb.frame = CGRectMake(0, 0, 70, 40);
    [titleLb setImageEdgeInsets:UIEdgeInsetsMake(0, 50, 0, 0)];
    [titleLb setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
    self.navigationItem.titleView = titleLb;

}

-(void)titleShowPopover{
    self.popover = [DXPopover new];
    self.popover.maskType = DXPopoverMaskTypeBlack;
    self.popover.contentInset = UIEdgeInsetsZero;
    self.popover.backgroundColor = [UIColor whiteColor];
//    CGSize arrowSize = self.popover.arrowSize;
//    arrowSize.width += randomFloatBetweenLowAndHigh(3.0, 5.0);
//    arrowSize.height += randomFloatBetweenLowAndHigh(3.0, 5.0);
//    self.popover.arrowSize = arrowSize;
    
    ActivityTypeView *typeView = [[ActivityTypeView alloc] initWithFrame:CGRectMake(0, 0, 160, 300)];
    typeView.backgroundColor = [UIColor clearColor];
    
    UIView *titleView = self.navigationItem.titleView;
    CGPoint startPoint =
    CGPointMake(CGRectGetMidX(titleView.frame), CGRectGetMaxY(titleView.frame) + 20);
    
    [self.popover showAtPoint:startPoint
               popoverPostion:DXPopoverPositionDown
              withContentView:typeView
                       inView:self.tabBarController.view];
    __weak typeof(self) weakSelf = self;
    self.popover.didDismissHandler = ^{
        [weakSelf bounceTargetView:titleView];
    };

}

- (void)bounceTargetView:(UIView *)targetView {
    targetView.transform = CGAffineTransformMakeScale(0.9, 0.9);
    [UIView animateWithDuration:0.5
                          delay:0.0
         usingSpringWithDamping:0.3
          initialSpringVelocity:5
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         targetView.transform = CGAffineTransformIdentity;
                     }
                     completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
