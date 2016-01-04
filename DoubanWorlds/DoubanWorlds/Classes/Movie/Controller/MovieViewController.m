//
//  MovieViewController.m
//  DoubanWorlds
//
//  Created by LYoung on 16/1/4.
//  Copyright © 2016年 LYoung. All rights reserved.
//

#import "MovieViewController.h"
#import "MovieMenuView.h"
#import "HotMovieController.h"
#import "NewFilmController.h"

#define MovieMenuHeight 45.f

@interface MovieViewController ()

@property (nonatomic, strong) HotMovieController *hotVC;
@property (nonatomic, strong) NewFilmController *newfilmVC;
@property (nonatomic, strong) NSMutableArray *viewControllers;
@property (nonatomic, strong) UIScrollView *backgroundScrollView;

@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadMenuView];
    
    [self loadControllers];
    
    [self loadScrollView];
    
    
}

- (void)loadMenuView{
    self.view.backgroundColor = [UIColor whiteColor];
    
    MovieMenuView *menuView = [[MovieMenuView alloc] init];
    menuView.frame = CGRectMake(0, 64, SCREEN_WIDTH, MovieMenuHeight);
    [self.view addSubview:menuView];
}

- (void)loadControllers{
    
    _viewControllers = [[NSMutableArray alloc] init];
    
    _hotVC = [[HotMovieController alloc] init];
    _newfilmVC = [[NewFilmController alloc] init];
    
    [self addChildViewController:_hotVC];
    [self addChildViewController:_newfilmVC];
    
    _viewControllers = [NSMutableArray arrayWithObjects:_newfilmVC,_newfilmVC,nil];
    
}

- (void)loadScrollView{
    
    NSInteger viewCounts = _viewControllers.count;
    
    //初始化最底部的scrollView,装tableView用
    self.backgroundScrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.backgroundScrollView.backgroundColor = [UIColor whiteColor];
    self.backgroundScrollView.pagingEnabled = YES;
    self.backgroundScrollView.bounces = NO;
    self.backgroundScrollView.showsHorizontalScrollIndicator = NO;
    self.backgroundScrollView.delegate = (id<UIScrollViewDelegate>)self;
    self.backgroundScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * viewCounts, 0);
    [self.view addSubview:self.backgroundScrollView];
    
    
    for (int i = 0; i < viewCounts; i++) {
        UIViewController *listCtrl = self.viewControllers[i];
        listCtrl.view.frame = CGRectMake(SCREEN_WIDTH*i, 64 + MovieMenuHeight, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self.backgroundScrollView addSubview:listCtrl.view];
    }
    
    [self.backgroundScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger pageIndex = (NSInteger)scrollView.contentOffset.x/SCREEN_WIDTH;
//    [_segmentedControl setSelectedSegmentIndex:pageIndex];
}

- (void)segmentedControlAction:(id)sender{
    NSInteger selectedIndex = [sender selectedSegmentIndex];
    
    [self.backgroundScrollView setContentOffset:CGPointMake(SCREEN_WIDTH*selectedIndex, 0) animated:NO];
    
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
