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

@interface RecommendViewController ()
{
    NSInteger _startNum;
}

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
    
    [self refreshData];
    
}

- (void)initTableView{
    self.view.backgroundColor = [UIColor whiteColor];

    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)])
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    _tableView                 = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.height, [UIScreen mainScreen].bounds.size.height - 64)];
    _tableView.delegate        = (id<UITableViewDelegate>)self;
    _tableView.dataSource      = (id<UITableViewDataSource>) self;
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:_tableView];
}

- (void)addRefreshView {
    
    __weak __typeof(self) weakSelf = self;
    
    //下拉刷新
    _tableView.refreshHeader = [_tableView addRefreshHeaderWithHandler:^ {
        [weakSelf refreshData];
    }];
    
    //上拉加载更多
    _tableView.refreshFooter = [_tableView addRefreshFooterWithHandler:^ {
        [weakSelf loadMoreData];
    }];
    //   _tableView.refreshFooter.autoLoadMore = NO;
}

- (void)refreshData {
    __weak __typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [RecommendHttpTool getRecommendList:_startNum loc:@"108288" arrayBlock:^(NSMutableArray *resultArray) {
            _resultArray = resultArray;
            [weakSelf.tableView reloadData];

        }];
        [weakSelf.tableView.refreshHeader endRefresh];
        
        weakSelf.tableView.refreshFooter.loadMoreEnabled = YES;
    });
}


- (void)loadMoreData {
    __weak __typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        _startNum++;
        [RecommendHttpTool getRecommendList:_startNum loc:@"108288" arrayBlock:^(NSMutableArray *resultArray) {
            [_resultArray addObjectsFromArray:resultArray];
            [weakSelf.tableView reloadData];
        }];
        [weakSelf.tableView.refreshFooter endRefresh];
        
//        weakSelf.tableView.refreshFooter.loadMoreEnabled = NO;
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _resultArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *reuseIdentifier = @"reuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    RecommendModel *model = [_resultArray objectAtIndex:indexPath.row];
    cell.textLabel.text = model.title;
    return cell;
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
