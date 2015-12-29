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

@interface RecommendViewController ()
{
    NSInteger _startNum;
}

@property (nonatomic, copy) NSString *locID;//当前城市ID
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *resultArray;

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
    
    
    [self requestData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityButtonClick:) name:kCityButtonClick object:nil];
    
    [self test];
}

- (void)test{
    
    //定位到的城市
    UIButton *_locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_locationBtn setTitle:@"北京" forState:UIControlStateNormal];
//    _locationBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 8);
    [_locationBtn setTitleColor:TheThemeColor forState:UIControlStateNormal];
    [_locationBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_locationBtn setImage:[UIImage imageNamed:@"AlbumLocationIconHL"] forState:UIControlStateNormal];
    [_locationBtn addTarget:self action:@selector(pushPickViewController) forControlEvents:UIControlEventTouchUpInside];
    
    _locationBtn.frame = CGRectMake(0, 0, 65, 40);
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:_locationBtn];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -20;
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, buttonItem];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(pushPickViewController)];



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
            
            self.locID = [ID copy];
            [self refreshDataLocID:ID];
            
            [[NSUserDefaults standardUserDefaults] setObject:cityName forKey:kCurrentLocation];

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
        }
    }
}
#pragma mark - 城市按钮点击
-(void)cityButtonClick:(NSNotification *)note{
    NSString *cname = note.userInfo[kCityButtonClick];
    if (cname) {
        NSString *ID = [LYCityHandler getCityIDByName:cname];
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
