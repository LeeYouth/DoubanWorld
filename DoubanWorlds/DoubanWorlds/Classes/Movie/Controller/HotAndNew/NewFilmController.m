//
//  NewFilmController.m
//  DoubanWorlds
//
//  Created by LYoung on 16/1/4.
//  Copyright © 2016年 LYoung. All rights reserved.
//

#import "NewFilmController.h"
#import "MovieDetailController.h"
#import "MovieHttpTool.h"
#import "MovieModel.h"
#import "HotMovieCell.h"
#import "LDRefresh.h"

@interface NewFilmController ()

@property (nonatomic, strong) NSMutableArray *resultArray;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation NewFilmController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.resultArray = [NSMutableArray arrayWithCapacity:1];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initTableView];
    
    [self addRefreshView];
    
    [self requestData];
    
    
}

- (void)addRefreshView {
    
    __weak __typeof(self) weakSelf = self;
    //下拉刷新
    _tableView.refreshHeader = [_tableView addRefreshHeaderWithHandler:^ {
        [weakSelf requestData];
    }];
    
    //上拉加载更多
    _tableView.refreshFooter = [_tableView addRefreshFooterWithHandler:^{
        [weakSelf loadMoreData];
    }];
}

#pragma mark - 下拉刷新数据
- (void)requestData{
    
    __weak NewFilmController *weakSelf = self;
    
    [MovieHttpTool getComingsoonWithStart:0 arrayBlock:^(NSMutableArray *resultArray) {
        _resultArray = resultArray;
        
        [weakSelf.tableView.refreshHeader endRefresh];
        [self.tableView reloadData];
        
    }];
}

#pragma mark - 上拉加载更多数据
- (void)loadMoreData{
    
    __weak NewFilmController *weakSelf = self;
    
    [MovieHttpTool getComingsoonWithStart:_resultArray.count arrayBlock:^(NSMutableArray *resultArray) {
        [_resultArray addObjectsFromArray: resultArray];
        
        [weakSelf.tableView.refreshFooter endRefresh];
        [self.tableView reloadData];
    }];
}

- (void)initTableView{
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - MovieMenuHeight - NAV_BAR_HEIGHT - TAB_BAR_HEIGHT)];
    _tableView.delegate = (id<UITableViewDelegate>)self;
    _tableView.dataSource = (id<UITableViewDataSource>) self;;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundColor = KBackgroundColor;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _resultArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MovieModel *model = [_resultArray objectAtIndex:indexPath.row];
    return [HotMovieCell getCellHeight:model];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HotMovieCell *hotCell = [HotMovieCell cellWithTableView:tableView];
    hotCell.model = [_resultArray objectAtIndex:indexPath.row];
    return hotCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MovieDetailController *detailVC = [[MovieDetailController alloc] init];
    detailVC.movieModel = [_resultArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];


}

@end
