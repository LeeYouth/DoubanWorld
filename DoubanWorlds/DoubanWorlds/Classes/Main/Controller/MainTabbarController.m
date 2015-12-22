//
//  MainTabbarController.m
//  AnecdotesDemo
//
//  Created by LYoung on 15/10/13.
//  Copyright (c) 2015年 LYoung. All rights reserved.
//

#import "MainTabbarController.h"
#import "MainNavgationController.h"
#import "ContentViewController.h"
#import "SettingViewController.h"
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

@implementation MainTabbarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (iOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    
    [self addAllChildViewControllers];
    
}



- (void)addAllChildViewControllers{

    
    NSArray *buttonImages = @[@"tabbar_mainframe", @"tabbar_discover", @"tabbar_contacts",@"tabbar_me"];
    NSArray *buttonImagesSelected = @[@"tabbar_mainframeHL", @"tabbar_discoverHL", @"tabbar_contactsHL",@"tabbar_meHL"];
    
    ContentViewController *contentsVC = [[ContentViewController alloc] init];
    [self addChildViewController:contentsVC title:@"微信" image:buttonImages[0] selectedImage:buttonImagesSelected[0]];
    
    UIViewController *pictureVC = [[UIViewController alloc] init];
    [self addChildViewController:pictureVC title:@"通讯录" image:buttonImages[1] selectedImage:buttonImagesSelected[1]];
    
    UIViewController *voiceVC = [[UIViewController alloc] init];
    [self addChildViewController:voiceVC title:@"发现" image:buttonImages[2] selectedImage:buttonImagesSelected[2]];
    
    SettingViewController *settingsVC = [[SettingViewController alloc] init];
    [self addChildViewController:settingsVC title:@"我" image:buttonImages[3] selectedImage:buttonImagesSelected[3]];
    
}

#pragma mark -添加一个控制器
/**
 *  添加一个子控制器
 *
 *  @param childController 控制器
 *  @param title           title
 *  @param image           image
 *  @param selectedImage   selectedImage
 */
-(void)addChildViewController:(UIViewController *)childController title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    //1.tababr标题
    childController.tabBarItem.title = title;
    UIImage *normal = [UIImage imageNamed:image];
    UIImage *selected = [UIImage imageNamed:selectedImage];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    if (iOS7) {
        childController.tabBarItem.image = [normal imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        childController.tabBarItem.selectedImage = [selected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }else{
        childController.tabBarItem.selectedImage = selected;
    }
    
    //2.包装导航控制器
    childController.title = title;
    MainNavgationController *mainNav = [[MainNavgationController alloc] initWithRootViewController:childController];
    [self addChildViewController:mainNav];
}


@end
