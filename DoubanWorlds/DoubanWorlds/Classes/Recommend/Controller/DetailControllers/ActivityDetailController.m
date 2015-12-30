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

@interface ActivityDetailController ()

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


- (void)initTableView{
    self.view.backgroundColor = [UIColor whiteColor];
    
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)])
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
   
    _tableView                 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    _tableView.delegate        = (id<UITableViewDelegate>)self;
    _tableView.dataSource      = (id<UITableViewDataSource>) self;
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
        CGRect f = self.expandZoomImageView.frame;
        f.origin.y = yOffset - 20;
        f.size.height =  -yOffset + 20;
        self.expandZoomImageView.frame = f;
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
    }else if(indexPath.row == 1){
        DetialSecondCell *secondCell = [DetialSecondCell cellWithTableView:tableView];
        secondCell.model = _activityModel;
        secondCell.isHidden = NO;
        secondCell.title = @"即时讨论";
        return secondCell;
    }else if(indexPath.row == 2){
        DetialSecondCell *thirdCell = [DetialSecondCell cellWithTableView:tableView];
        thirdCell.model = _activityModel;
        thirdCell.isHidden = YES;
        thirdCell.title = @"地址";
        return thirdCell;
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
    
    
}


@end
