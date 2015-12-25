//
//  PickCityViewController.m
//  DoubanWorlds
//
//  Created by LYoung on 15/12/25.
//  Copyright © 2015年 LYoung. All rights reserved.
//

#import "PickCityViewController.h"
#import "CityIndexCell.h"
#import "SectionHeaderView.h"

@interface PickCityViewController ()

@property (nonatomic, strong) NSMutableArray *sectionArray;
@property (nonatomic, strong) NSMutableArray *indexArray;
@property (nonatomic, strong) NSDictionary *resultDict;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation PickCityViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.sectionArray = [NSMutableArray arrayWithCapacity:1];
        self.indexArray = [NSMutableArray arrayWithCapacity:1];
        self.resultDict = [[NSDictionary alloc] init];

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
    
    
    NSString *inlandPlistURL = [[NSBundle mainBundle] pathForResource:@"inLandCityGroup" ofType:@"plist"];
    NSDictionary *cityGroupDic = [[NSDictionary alloc] initWithContentsOfFile:inlandPlistURL];
    
    _resultDict = [cityGroupDic copy];
    
    NSArray *sections = [cityGroupDic allKeys];
    // 对该数组里边的元素进行升序排序
    sections = [sections sortedArrayUsingSelector:@selector(compare:)];
    _sectionArray = [sections copy];
    
    
    NSArray *indexs = [cityGroupDic allValues];
    [_indexArray addObjectsFromArray:indexs];
    
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
    return _indexArray.count;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    SectionHeaderView *headerView = [[SectionHeaderView alloc] init];
    headerView.text = [_sectionArray objectAtIndex:section];
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25;
}
-(NSArray *)sectionIndexsAtIndexes:(NSIndexSet *)indexes{
    return _sectionArray;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // 返回cell条数
    NSString *key = [_sectionArray objectAtIndex:section];
    NSArray *array = [_resultDict valueForKey:key];
    return array.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CityIndexCell getCellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CityIndexCell *indexCell = [CityIndexCell cellWithTableView:tableView];
    
    NSString *key = [_sectionArray objectAtIndex:indexPath.section];
    NSArray *array = [_resultDict valueForKey:key];
    NSDictionary *sss = [array objectAtIndex:indexPath.row];
    NSEnumerator * enumeratorKey = [sss keyEnumerator];
    NSString *value;
    while((value = [enumeratorKey nextObject]))
    {
        NSLog(@"遍历的值: %@",value);
        indexCell.cityName = value;
    }
    

    return indexCell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}




@end
