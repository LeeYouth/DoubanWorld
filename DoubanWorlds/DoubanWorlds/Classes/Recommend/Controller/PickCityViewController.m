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

@interface PickCityViewController ()

@property (nonatomic, strong) NSMutableArray *sectionArray;
@property (nonatomic, strong) NSMutableArray *allIndexArray;
@property (nonatomic, strong) NSDictionary *citiesDic;

@property (nonatomic, strong) UITableView *tableView;

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
    // Do any additional setup after loading the view.
    
    
    [self initTableView];
    
    [self requestData];
}

-(void)requestData{
    
    [RecommendHttpTool getCityInfo:^(NSDictionary *resDict, NSArray *firstArray, NSArray *secondArray) {
        _citiesDic = [resDict copy];
        _sectionArray = [firstArray copy];
        _allIndexArray = [secondArray copy];
    }];
    
    [self.tableView reloadData];
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
    [self.view addSubview:_tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _allIndexArray.count;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    SectionHeaderView *headerView = [[SectionHeaderView alloc] init];
    headerView.text = [_sectionArray objectAtIndex:section];
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [SectionHeaderView getSectionHeadHeight];
}
-(NSArray *)sectionIndexsAtIndexes:(NSIndexSet *)indexes{
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




@end
