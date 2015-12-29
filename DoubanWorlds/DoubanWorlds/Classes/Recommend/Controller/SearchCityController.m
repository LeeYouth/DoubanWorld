//
//  SearchCityController.m
//  DoubanWorlds
//
//  Created by LYoung on 15/12/29.
//  Copyright © 2015年 LYoung. All rights reserved.
//

#import "SearchCityController.h"
#import "YLYSearchBar.h"
#import "CityIndexCell.h"

@interface SearchCityController ()
{
    YLYSearchBar *_searchTF;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *searchResultArray;

@end

@implementation SearchCityController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    

    [self initTableView];
    
    [self initSearchBar];
    
}

-(void)initTableView{
    //搜索tableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.dataSource = (id<UITableViewDataSource>)self;
    _tableView.delegate = (id<UITableViewDelegate>)self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [AppTools colorWithHexString:@"f8f8f8"];
    [self.view addSubview:_tableView];
    
}

-(void)initSearchBar{
    CGFloat searchViewW = SCREEN_WIDTH;
    CGFloat searchViewH = 44;
    UIView *searchView = [[UIView alloc] init];
    searchView.backgroundColor = [UIColor clearColor];
    searchView.frame = CGRectMake(0, 0, searchViewW, searchViewH);
    
    CGFloat searchBarW = SCREEN_WIDTH - 60;
    CGFloat searchBarH = 32;
    CGFloat searchBarX = 5;
    
    _searchTF = [[YLYSearchBar alloc] init];
    _searchTF.keyboardType = UIKeyboardTypeWebSearch;
    _searchTF.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _searchTF.layer.borderWidth = 0.2;
    _searchTF.layer.cornerRadius = 4;
    _searchTF.delegate = (id<UITextFieldDelegate>)self;
    _searchTF.backgroundColor = KBackgroundColor;
    _searchTF.frame = CGRectMake(0, searchBarX, searchBarW, searchBarH);
    [_searchTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [searchView addSubview:_searchTF];
    
    CGFloat cancelBtnX = SCREEN_WIDTH - 65;
    CGFloat cancelBtnW = 60;
    CGFloat cancelBtnH = searchBarH;
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(cancelBtnX, searchBarX, cancelBtnW, cancelBtnH);
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:17.f];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:TheThemeColor forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [searchView addSubview:cancelButton];
    
    self.navigationItem.titleView = searchView;
    
    self.navigationItem.leftBarButtonItem = nil;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [_searchTF becomeFirstResponder];
}

#pragma mark - 取消操作
-(void)cancelAction{
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"pageUnCurl";
    animation.type = kCATransitionFade;
    //    animation.subtype = kCATransitionFromBottom;
    [self.view.window.layer addAnimation:animation forKey:nil];
    
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CityIndexCell getCellHeight];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CityIndexCell *cell = [CityIndexCell cellWithTableView:tableView];
    cell.cityName = @"北京";
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


#pragma mark - textField字符改变的监听方法
- (void)textFieldDidChange:(UITextField *)textField{
    NSLog(@"textFiled string = %@",_searchTF.text);
    
    if (textField.text.length > 0) {

    }else
    {

    }
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_searchTF resignFirstResponder];
    if (textField.text.length <=0) {
        
    }else{
        
      
    }
    
    return YES;
}


#pragma mark - scrollView 代理方法
#pragma mark - UIScrollViewDelegate代理
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    [_searchTF resignFirstResponder];
}

@end
