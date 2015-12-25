//
//  PickCityViewController.m
//  DoubanWorlds
//
//  Created by LYoung on 15/12/25.
//  Copyright © 2015年 LYoung. All rights reserved.
//

#import "PickCityViewController.h"
#import "RecommendHttpTool.h"
#import "CityIndexCell.h"
#import "SectionHeaderView.h"
#import "LYCityHandler.h"
#import "YLYTableViewIndexView.h"
#import "ChinaCityHeadView.h"

@interface PickCityViewController ()<YLYTableViewIndexDelegate>

@property (nonatomic, strong) NSMutableArray *sectionArray;
@property (nonatomic, strong) NSMutableArray *allIndexArray;
@property (nonatomic, strong) NSDictionary *citiesDic;

@property (nonatomic, strong) ChinaCityHeadView *headView;
@property (nonatomic, strong) YLYTableViewIndexView *indexView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *flotageLabel;//显示视图

@end

@implementation PickCityViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.sectionArray = [NSMutableArray arrayWithCapacity:1];
        self.allIndexArray = [NSMutableArray arrayWithCapacity:1];
        self.citiesDic = [[NSDictionary alloc] init];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initTableView];
    
    //国内数据
    [self requestChinaData];
    
    [self initIndexView];
    
    [self initUISegmentedControl];
}

#pragma - 国内数据
- (void)requestChinaData{
    
    [RecommendHttpTool getChinaCityInfo:^(NSDictionary *resDict, NSArray *firstArray, NSArray *secondArray) {
        _citiesDic = [resDict copy];
        _sectionArray = [firstArray copy];
        _allIndexArray = [secondArray copy];
    }];
    
    [self.tableView reloadData];
    
    [self reloadIndexFrame];
}
#pragma mark - 国外数据
- (void)requestOverseasData{
    [RecommendHttpTool getOverseasCityInfo:^(NSDictionary *resDict, NSArray *firstArray, NSArray *secondArray) {
        _citiesDic = [resDict copy];
        _sectionArray = [firstArray copy];
        _allIndexArray = [secondArray copy];
    }];
    
    [self.tableView reloadData];
    [self reloadIndexFrame];

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
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
    
    _headView = [[ChinaCityHeadView alloc] init];
    _headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 100);
    _headView.backgroundColor = [UIColor redColor];
    _tableView.tableHeaderView = _headView;
    
}

- (void)initIndexView{
    self.flotageLabel = [[UILabel alloc] init];
    self.flotageLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"flotageBackgroud"]];
    self.flotageLabel.hidden = YES;
    self.flotageLabel.textAlignment = NSTextAlignmentCenter;
    self.flotageLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.flotageLabel];
    [self.flotageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(64, 64));
    }];
    
    //indexView
    _indexView = [[YLYTableViewIndexView alloc] initWithFrame:(CGRect){SCREEN_WIDTH - 20,0,20,SCREEN_HEIGHT}];
    [self.view addSubview:_indexView];
    
    [self reloadIndexFrame];
}
#pragma mark - 刷新索引视图
- (void)reloadIndexFrame{
    _indexView.tableViewIndexDelegate = self;
    CGRect rect = _indexView.frame;
    rect.size.height = _sectionArray.count * 16;
    rect.origin.y = (SCREEN_HEIGHT - rect.size.height + 44) / 2;
    _indexView.frame = rect;
}

- (void)initUISegmentedControl{
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"国内",@"国外",nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    segmentedControl.frame = CGRectMake(0,0,180,30);
    segmentedControl.tintColor = TheThemeColor;
    [segmentedControl setSelectedSegmentIndex:0];
    [segmentedControl addTarget:self action:@selector(segmentedControlAction:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segmentedControl;
}

- (void)segmentedControlAction:(id)sender{
    NSInteger selectedIndex = [sender selectedSegmentIndex];
    if (selectedIndex == 0) {
        [self requestChinaData];
        _tableView.tableHeaderView = _headView;
    }else{
        [self requestOverseasData];
        _tableView.tableHeaderView = nil;

    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _allIndexArray.count;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    SectionHeaderView *headerView = [[SectionHeaderView alloc] init];
    headerView.text = [_sectionArray objectAtIndex:section];
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [SectionHeaderView getSectionHeadHeight];
}
- (NSArray *)sectionIndexsAtIndexes:(NSIndexSet *)indexes{
    return _sectionArray;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // 返回cell条数
    return [LYCityHandler getOneSectionCountWithSectionArr:_sectionArray cityDict:_citiesDic section:section];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CityIndexCell getCellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CityIndexCell *cell = [CityIndexCell cellWithTableView:tableView];
    NSString *objKey = [LYCityHandler getCityNameWithSectionArr:_sectionArray cityDict:_citiesDic indexPath:indexPath];
    cell.cityName = objKey;
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *objValue = [LYCityHandler getCityIDWithSectionArr:_sectionArray cityDict:_citiesDic indexPath:indexPath];
    NSLog(@"---------选择的城市ID = %@",objValue);
    
}

#pragma mark -YLYTableViewIndexDelegate
- (void)tableViewIndex:(YLYTableViewIndexView *)tableViewIndex didSelectSectionAtIndex:(NSInteger)index withTitle:(NSString *)title{
    if ([_tableView numberOfSections] > index && index > -1){   // for safety, should always be YES
        [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index]
                    atScrollPosition:UITableViewScrollPositionTop
                            animated:NO];
        self.flotageLabel.text = title;
    }
}
- (void)tableViewIndexTouchesBegan:(YLYTableViewIndexView *)tableViewIndex{
    self.flotageLabel.hidden = NO;
}
- (void)tableViewIndexTouchesEnd:(YLYTableViewIndexView *)tableViewIndex{
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.4;
    [self.flotageLabel.layer addAnimation:animation forKey:nil];
    self.flotageLabel.hidden = YES;
}
- (NSArray *)tableViewIndexTitle:(YLYTableViewIndexView *)tableViewIndex{
    return _sectionArray;
}


@end
