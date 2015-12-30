//
//  ActivityDetailController.m
//  DoubanWorlds
//
//  Created by LYoung on 15/12/29.
//  Copyright © 2015年 LYoung. All rights reserved.
//

#import "ActivityDetailController.h"
#import "BLRColorComponents.h"
#import "UIImage+ImageEffects.h"

@interface ActivityDetailController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *expandZoomImageView;

@end

@implementation ActivityDetailController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor redColor];
    
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
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    _tableView.contentInset = UIEdgeInsetsMake(KActivityDetailHeadH, 0, 0, 0);
    
    _expandZoomImageView = [[UIImageView alloc] init];
    _expandZoomImageView.frame = CGRectMake(0, -KActivityDetailHeadH, SCREEN_WIDTH, KActivityDetailHeadH);
    _expandZoomImageView.userInteractionEnabled = YES;
    _expandZoomImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_tableView addSubview: _expandZoomImageView];
    
    UIColor *tintColor = [UIColor colorWithWhite:0.11 alpha:0.73];
    [_expandZoomImageView setImage:[[UIImage imageNamed:@"blog_homepage_headerbg"] applyBlurWithRadius:5 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil]];

    
    UIView *headView = [[UIView alloc] init];
    headView.backgroundColor = [UIColor clearColor];
    headView.frame = CGRectMake(0, -KActivityDetailHeadH , SCREEN_WIDTH, KActivityDetailHeadH );
    [_tableView addSubview: headView];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat yOffset  = scrollView.contentOffset.y;
    if (yOffset < -KActivityDetailHeadH - 64) {
        CGRect f = self.expandZoomImageView.frame;
        f.origin.y = yOffset - 20;
        f.size.height =  -yOffset + 20;
        self.expandZoomImageView.frame = f;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
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
    cell.textLabel.text = @"测试数据---";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}


@end
