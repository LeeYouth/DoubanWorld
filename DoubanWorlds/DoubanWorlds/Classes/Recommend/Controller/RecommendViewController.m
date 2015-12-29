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
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(pushPickViewController)];
    
    [self requestData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityButtonClick:) name:kCityButtonClick object:nil];
}

-(void)requestData{
    LocationManager *manager = [LocationManager sharedFOLClient];
    __weak RecommendViewController *weekSelf = self;
    [manager currentLocation:^(CLLocation *currentLocation, NSString *cityName) {
        NSLog(@"currentLocation = %@,cityName = %@",currentLocation,cityName);
        NSString *ID = [LYCityHandler getCityIDByName:cityName];
        NSLog(@"cityID = %@",ID);
        
        weekSelf.locID = [ID copy];
        [weekSelf refreshDataLocID:ID];
    }];
}
#pragma mark - 城市按钮点击
-(void)cityButtonClick:(NSNotification *)note{
    NSString *cname = note.userInfo[kCityButtonClick];
    if (cname) {
        NSString *ID = [LYCityHandler getCityIDByName:cname];
        self.locID = [ID copy];
        [self refreshDataLocID:ID];
    }
}


-(void)pushPickViewController{
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
