//
//  ActivityDetailController.m
//  DoubanWorlds
//
//  Created by LYoung on 15/12/29.
//  Copyright © 2015年 LYoung. All rights reserved.
//

#import "ActivityDetailController.h"
#import "UIImage+ImageEffects.h"
#import "RecommendHttpTool.h"
#import "BLRColorComponents.H"
#import "DetailHeadView.h"
#import "DetailFirstRowCell.h"
#import "DetialSecondCell.h"
#import "DetailContentCell.h"
#import "MapViewController.h"

@interface ActivityDetailController ()<UITableViewDelegate,UITableViewDataSource>
{
    UILabel *_titleLabel;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *expandZoomImageView;

@end

@implementation ActivityDetailController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTableView];
    
    [self.tableView reloadData];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (iOS7) {
        self.edgesForExtendedLayout = UIRectEdgeAll;
        self.automaticallyAdjustsScrollViewInsets = YES;
        self.extendedLayoutIncludesOpaqueBars = NO;
    }
    [self.navigationController.navigationBar setTranslucent:YES];

    //为什么要加这个呢，shadowImage 是在ios6.0以后才可用的。但是发现5.0也可以用。不过如果你不判断有没有这个方法，
    //而直接去调用可能会crash，所以判断下。作用：如果你设置了上面那句话，你会发现是透明了。但是会有一个阴影在，下面的方法就是去阴影
    if ([self.navigationController.navigationBar respondsToSelector:@selector(shadowImage)])
    {
        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    }
    //以上面4句是必须的,但是习惯还是加了下面这句话
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];

}


- (void)initTableView{
    self.view.backgroundColor = [UIColor whiteColor];
    
    //标题
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.font = [UIFont systemFontOfSize:16.0];
    _titleLabel.frame = CGRectMake(SCREEN_WIDTH/2 - 100, 20, 200, 20);
    self.navigationItem.titleView = _titleLabel;
    _titleLabel.text = _activityModel.title;
    _titleLabel.hidden = YES;

   
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT )];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.contentInset = UIEdgeInsetsMake(KActivityDetailHeadH, 0, 0, 0);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    
    _expandZoomImageView = [[UIImageView alloc] init];
    _expandZoomImageView.frame = CGRectMake(0, -KActivityDetailHeadH, SCREEN_WIDTH, KActivityDetailHeadH);
    _expandZoomImageView.userInteractionEnabled = YES;
    _expandZoomImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_tableView addSubview: _expandZoomImageView];
    
    UIColor *tintColor = [BLRColorComponents darkEffect].tintColor;
    NSURL *imgURL = [NSURL URLWithString:_activityModel.image];
    
    [[SDWebImageManager sharedManager] downloadImageWithURL:imgURL options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize){
         //处理下载进度
     } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
         [_expandZoomImageView setImage:[image applyBlurWithCrop:CGRectMake(0, 0, SCREEN_HEIGHT, KActivityDetailHeadH) resize:CGSizeMake(SCREEN_WIDTH, KActivityDetailHeadH) blurRadius:[BLRColorComponents darkEffect].radius tintColor:tintColor saturationDeltaFactor:[BLRColorComponents darkEffect].saturationDeltaFactor maskImage:nil]];
     }];


    
    DetailHeadView *headView = [[DetailHeadView alloc] init];
    headView.frame = CGRectMake(0, -KActivityDetailHeadH , SCREEN_WIDTH, KActivityDetailHeadH );
    headView.activityModel = _activityModel;
    [_tableView addSubview: headView];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat yOffset  = scrollView.contentOffset.y;
    if (yOffset < -KActivityDetailHeadH ) {
        CGRect f = _expandZoomImageView.frame;
        f.origin.y = yOffset - 20;
        f.size.height =  -yOffset + 20;
        _expandZoomImageView.frame = f;
    }
    
    CGFloat offset = KMovieDetailHeadH - 64;
    if (yOffset > -offset) {//取消隐藏
        _titleLabel.hidden = NO;
    }else{//隐藏
        _titleLabel.hidden = YES;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return [DetailFirstRowCell getCellHeight:_activityModel];
    }else if(indexPath.row == 1 || indexPath.row == 2){
        return [DetialSecondCell getCellHeight];
    }else if(indexPath.row == 3){
        return [DetailContentCell getCellHeight:_activityModel];
    }else{
        return [DetailFirstRowCell getCellHeight:_activityModel];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        DetailFirstRowCell *firstCell = [DetailFirstRowCell cellWithTableView:tableView];
        firstCell.model = _activityModel;
        return firstCell;
    }else if(indexPath.row == 1 || indexPath.row == 2){
        DetialSecondCell *secondCell = [DetialSecondCell cellWithTableView:tableView];
        secondCell.model = _activityModel;
        switch (indexPath.row) {
            case 1:
                secondCell.title = @"即时讨论";
                break;
            case 2:
                secondCell.title = @"地址";
                break;
                
            default:
                break;
        }
        
        return secondCell;
    }else if(indexPath.row == 3){
        DetailContentCell *contentCell = [DetailContentCell cellWithTableView:tableView];
        contentCell.model = _activityModel;
        return contentCell;
    }else{
        DetailFirstRowCell *firstCell = [DetailFirstRowCell cellWithTableView:tableView];
        firstCell.model = _activityModel;
        return firstCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 2) {
        MapViewController *mapVC = [[MapViewController alloc] init];
        mapVC.address = _activityModel.address;
        mapVC.activityName = _activityModel.title;
        mapVC.geo = _activityModel.geo;
        [self.navigationController pushViewController:mapVC animated:YES];
    }
}


-(void)dealloc{
    _tableView.delegate = nil;
}

@end
