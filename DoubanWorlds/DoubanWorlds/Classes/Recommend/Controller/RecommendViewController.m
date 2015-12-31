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
    UIButton *_titleLBtn;
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(typeButtonClick:) name:kTypeButtonClick object:nil];

    
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
            NSString *acType = @"all";
            
            [[NSUserDefaults standardUserDefaults] setObject:acType forKey:kCurrentActiveType];

            
            self.locID = [ID copy];
            [self refreshDataLocID:ID];
            
            [[NSUserDefaults standardUserDefaults] setObject:cityName forKey:kCurrentLocation];

        }else//不是第一次登录
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
        }
    }
}

#pragma mark - 设置左边按钮
- (void)setLeftBtnTitle:(NSString *)title{
    [_locationBtn setTitle:title forState:UIControlStateNormal];
}
#pragma mark - 设置title
- (void)setTitleBtnTitle:(NSString *)title{
    [_titleLBtn setTitle:title forState:UIControlStateNormal];
}

#pragma mark - 城市按钮点击
- (void)cityButtonClick:(NSNotification *)note{
    NSString *cname = note.userInfo[kCityButtonClick];

    if (cname) {
        NSString *ID = [LYCityHandler getCityIDByName:cname];
        [_locationBtn setTitle:cname forState:UIControlStateNormal];

        self.locID = [ID copy];
        
        [self refreshDataLocID:self.locID];
        
        [[NSUserDefaults standardUserDefaults] setValue:cname forKey:kCityButtonClick];

        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kIsCityButtonClick];
    }
}

#pragma mark - 类型选择
- (void)typeButtonClick:(NSNotification *)note{
    [self.popover dismiss];

    NSString *acType = note.userInfo[kTypeButtonClick];
    
    if (acType) {
        NSString *cname = [LYCityHandler getCityNameByUID:self.locID];
        [_locationBtn setTitle:cname forState:UIControlStateNormal];
        [self refreshDataLocID:self.locID];
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

- (void)refreshDataLocID:(NSString *)cityID{
    NSString *acType = [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentActiveType];
    [self setLeftBtnTitle:[LYCityHandler getCityNameByUID:cityID]];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjects:@[@"热门",@"音乐",@"戏剧",@"展览",@"讲座",@"聚会",@"运动",@"旅行",@"公益",@"电影"] forKeys:@[@"all",@"music",@"drama",@"exhibition",@"salon",@"party", @"sports", @"travel", @"commonweal",@"film"] ];
    [self setTitleBtnTitle:[dict objectForKey:acType]];
    __weak __typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        [RecommendHttpTool getRecommendList:_startNum loc:self.locID type:acType arrayBlock:^(NSMutableArray *resultArray) {
            
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






- (void)setupNavTitleView{
    
    NSString *acType = [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentActiveType];

    NSDictionary *dict = [[NSDictionary alloc] initWithObjects:@[@"热门",@"音乐",@"戏剧",@"展览",@"讲座",@"聚会",@"运动",@"旅行",@"公益",@"电影"] forKeys:@[@"all",@"music",@"drama",@"exhibition",@"salon",@"party", @"sports", @"travel", @"commonweal",@"film"] ];
    
    //定位到的城市
    _titleLBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_titleLBtn setTitle:[dict objectForKey:acType] forState:UIControlStateNormal];
    [_titleLBtn setTitleColor:TheThemeColor forState:UIControlStateNormal];
    [_titleLBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:16.f]];
    [_titleLBtn setImage:[UIImage imageNamed:@"LuckyMoney_ChangeArrow"] forState:UIControlStateNormal];
    [_titleLBtn addTarget:self action:@selector(titleShowPopover) forControlEvents:UIControlEventTouchUpInside];
    _titleLBtn.frame = CGRectMake(0, 0, 80, 40);
    [_titleLBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 60, 0, 0)];
    [_titleLBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
    self.navigationItem.titleView = _titleLBtn;

}

- ( void)titleShowPopover{
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

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
