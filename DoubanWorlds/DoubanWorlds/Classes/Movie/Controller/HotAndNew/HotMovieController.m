//
//  HotMovieController.m
//  DoubanWorlds
//
//  Created by LYoung on 16/1/4.
//  Copyright © 2016年 LYoung. All rights reserved.
//  

#import "HotMovieController.h"
#import "MovieHttpTool.h"
#import "MovieModel.h"
#import "HotMovieCell.h"

@interface HotMovieController ()

@property (nonatomic, strong) NSMutableArray *resultArray;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HotMovieController

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
    
    [self requestData];
    
}

-(void)requestData{
    [MovieHttpTool getHotMovieWithStart:0 arrayBlock:^(NSMutableArray *resultArray) {
        _resultArray = resultArray;
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
