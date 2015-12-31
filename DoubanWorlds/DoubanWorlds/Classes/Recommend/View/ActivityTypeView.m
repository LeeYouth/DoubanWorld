//
//  ActivityTypeView.m
//  DoubanWorlds
//
//  Created by LYoung on 15/12/31.
//  Copyright © 2015年 LYoung. All rights reserved.
//

#import "ActivityTypeView.h"
#import "ActivityTypeCell.h"

#define TypeDict [[NSDictionary alloc] initWithObjects:@"all",@"music",@"drama",@"exhibition",@"salon",@"party", @"sports", @"travel", @"commonweal",@"film" forKeys:@"热门",@"音乐",@"戏剧",@"展览",@"讲座",@"聚会",@"运动",@"旅行",@"公益",@"电影" ]

@interface ActivityTypeView()
{
    NSArray *_dataArray;
    NSArray *_nameArray;
}
@property (nonatomic, strong) UITableView *tableView;

@end
@implementation ActivityTypeView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initTableView:frame];
        
        
        _dataArray = [[NSArray alloc] initWithObjects:@"热门",@"音乐",@"戏剧",@"展览",@"讲座",@"聚会",@"运动",@"旅行",@"公益",@"电影", nil];
        _nameArray = [[NSArray alloc] initWithObjects:@"type-meet",@"type-polaroid-socialmatic",@"type-radio-4",@"type-sharpner",@"type-support",@"type-sunglasses",@"type-nike-dunk",@"type-snowman",@"power-plant",@"type-pan", nil];

        [_tableView reloadData];
    }
    return self;
}

-(void)initTableView:(CGRect)frame{
    _tableView                 = [[UITableView alloc] initWithFrame:frame];
    _tableView.delegate        = (id<UITableViewDelegate>)self;
    _tableView.dataSource      = (id<UITableViewDataSource>) self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    [self addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [ActivityTypeCell getCellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {    
    ActivityTypeCell *cell = [ActivityTypeCell cellWithTableView:tableView];
    cell.title = [_dataArray objectAtIndex:indexPath.row];
    cell.imageName = [_nameArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *title = [_dataArray objectAtIndex:indexPath.row];

    NSDictionary *dict = [[NSDictionary alloc] initWithObjects:@[@"all",@"music",@"drama",@"exhibition",@"salon",@"party", @"sports", @"travel", @"commonweal",@"film"] forKeys:@[@"热门",@"音乐",@"戏剧",@"展览",@"讲座",@"聚会",@"运动",@"旅行",@"公益",@"电影"] ];

    NSString *type = [dict objectForKey:title];
    
    [[NSUserDefaults standardUserDefaults] setObject:type forKey:kCurrentActiveType];

    [[NSNotificationCenter defaultCenter] postNotificationName:kTypeButtonClick object:nil userInfo:@{kTypeButtonClick : type}];
    
    
}

@end
