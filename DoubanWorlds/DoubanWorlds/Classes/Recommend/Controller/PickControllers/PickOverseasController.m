//
//  PickOverseasController.m
//  DoubanWorlds
//
//  Created by LYoung on 15/12/28.
//  Copyright © 2015年 LYoung. All rights reserved.
//

#import "PickOverseasController.h"
#import "RecommendHttpTool.h"
#import "CityIndexCell.h"
#import "SectionHeaderView.h"
#import "LYCityHandler.h"
#import "YLYTableViewIndexView.h"

@interface PickOverseasController ()<YLYTableViewIndexDelegate>

@property (nonatomic, strong) NSMutableArray *sectionArray;
@property (nonatomic, strong) NSMutableArray *allIndexArray;
@property (nonatomic, strong) NSDictionary *citiesDic;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *flotageLabel;//显示视图

@end

@implementation PickOverseasController

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
    [self requestOverseasData];
    
    [self initIndexView];
    
}

#pragma mark - 国外数据
- (void)requestOverseasData{
    [RecommendHttpTool getOverseasCityInfo:^(NSDictionary *resDict, NSArray *firstArray, NSArray *secondArray) {
        _citiesDic = [resDict copy];
        _sectionArray = [firstArray copy];
        _allIndexArray = [secondArray copy];
    }];
    
    [self.tableView reloadData];
    
}

- (void)initTableView{
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tableView                 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _tableView.delegate        = (id<UITableViewDelegate>)self;
    _tableView.dataSource      = (id<UITableViewDataSource>) self;
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
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
    YLYTableViewIndexView *indexView = [[YLYTableViewIndexView alloc] initWithFrame:(CGRect){SCREEN_WIDTH - 20,0,20,SCREEN_HEIGHT}];
    indexView.tableViewIndexDelegate = self;
    [self.view addSubview:indexView];
    
    CGRect rect = indexView.frame;
    rect.size.height = _sectionArray.count * 16;
    rect.origin.y = (SCREEN_HEIGHT - 64 - rect.size.height) / 2;
    indexView.frame = rect;
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
