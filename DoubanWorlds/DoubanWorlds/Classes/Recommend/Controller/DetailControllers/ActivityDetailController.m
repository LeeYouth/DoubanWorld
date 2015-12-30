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
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    
    _expandZoomImageView = [[UIImageView alloc] init];
    _expandZoomImageView.frame = CGRectMake(0, -KActivityDetailHeadH, SCREEN_WIDTH, KActivityDetailHeadH);
    _expandZoomImageView.userInteractionEnabled = YES;
    _expandZoomImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_tableView addSubview: _expandZoomImageView];
    
    UIColor *tintColor = [BLRColorComponents darkEffect].tintColor;
    NSURL *imgURL = [NSURL URLWithString:_activityModel.image];
    UIImageView *immm = [[UIImageView alloc] init];
    [immm sd_setImageWithURL:imgURL];
    UIImage *backImage = immm.image;

    if (backImage) {
        [_expandZoomImageView setImage:[backImage applyBlurWithCrop:CGRectMake(0, 0, SCREEN_HEIGHT, KActivityDetailHeadH) resize:CGSizeMake(SCREEN_WIDTH, KActivityDetailHeadH) blurRadius:[BLRColorComponents darkEffect].radius tintColor:tintColor saturationDeltaFactor:[BLRColorComponents darkEffect].saturationDeltaFactor maskImage:nil]];
    }
    
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
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndertifer = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndertifer];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndertifer];
    }
    cell.textLabel.text = _activityModel.content;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}


@end
