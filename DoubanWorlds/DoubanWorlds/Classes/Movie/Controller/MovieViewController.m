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

@interface MovieViewController ()

@property (nonatomic, strong) HotMovieController *hotVC;
@property (nonatomic, strong) NewFilmController *newfilmVC;
@property (nonatomic, strong) NSMutableArray *viewControllers;
@property (nonatomic, strong) UIScrollView *backgroundScrollView;

@end

@implementation MovieViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadMenuView];
    
    [self loadControllers];
    
    [self loadScrollView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieMenuBtnClick:) name:kMovieMenuBtnClick object:nil];

}

- (void)loadMenuView{
    
    MovieMenuView *menuView = [[MovieMenuView alloc] init];
    menuView.backgroundColor = [UIColor whiteColor];
    menuView.frame = CGRectMake(0, NAV_BAR_HEIGHT, SCREEN_WIDTH, MovieMenuHeight);
    [self.view addSubview:menuView];
}

- (void)loadControllers{
    
    _viewControllers = [[NSMutableArray alloc] init];
    
    _hotVC = [[HotMovieController alloc] init];
    _newfilmVC = [[NewFilmController alloc] init];
    
    [self addChildViewController:_hotVC];
    [self addChildViewController:_newfilmVC];
    
    _viewControllers = [NSMutableArray arrayWithObjects:_hotVC,_newfilmVC,nil];
    
}

- (void)loadScrollView{
    
    NSInteger viewCounts = _viewControllers.count;
    
    //初始化最底部的scrollView,装tableView用
    self.backgroundScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAV_BAR_HEIGHT + MovieMenuHeight, SCREEN_WIDTH, SCREEN_HEIGHT - MovieMenuHeight - NAV_BAR_HEIGHT - TAB_BAR_HEIGHT)];
    self.backgroundScrollView.backgroundColor = KBackgroundColor;
    self.backgroundScrollView.pagingEnabled = YES;
    self.backgroundScrollView.bounces = NO;
    self.backgroundScrollView.showsHorizontalScrollIndicator = NO;
    self.backgroundScrollView.delegate = (id<UIScrollViewDelegate>)self;
    self.backgroundScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * viewCounts, 0);
    [self.view addSubview:self.backgroundScrollView];
    
    
    for (int i = 0; i < viewCounts; i++) {
        UIViewController *listCtrl = self.viewControllers[i];
        listCtrl.view.frame = CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, SCREEN_HEIGHT - MovieMenuHeight - NAV_BAR_HEIGHT - TAB_BAR_HEIGHT );
        [self.backgroundScrollView addSubview:listCtrl.view];
    }
    
    [self.backgroundScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger pageIndex = (NSInteger)scrollView.contentOffset.x/SCREEN_WIDTH;

    [[NSNotificationCenter defaultCenter] postNotificationName:kMovieScrollViewMove object:nil userInfo:@{kMovieScrollViewMove : [NSString stringWithFormat:@"%ld",pageIndex]}];

}

#pragma mark - kMovieMenuBtnClickNote
- (void)movieMenuBtnClick:(NSNotification *)note{
    NSString *indexNum = note.userInfo[kMovieMenuBtnClick];
    
    [self.backgroundScrollView setContentOffset:CGPointMake(SCREEN_WIDTH*[indexNum intValue], 0) animated:NO];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
