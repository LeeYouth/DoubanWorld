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
#import "ChineseInclude.h"
#import "PinYinForObjc.h"
#import "LYCityHandler.h"

@interface SearchCityController ()
{
    YLYSearchBar *_searchTF;
    UIView *_warningView;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *searchResultArray;
@property (nonatomic, strong) NSMutableArray *searchResults;
@end

@implementation SearchCityController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    

    [self initTableView];
    
    [self initSearchBar];
    
    [self initWarningLabel];
    
}

- (void)initTableView{
    //搜索tableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.dataSource = (id<UITableViewDataSource>)self;
    _tableView.delegate = (id<UITableViewDelegate>)self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [AppTools colorWithHexString:@"f8f8f8"];
    [self.view addSubview:_tableView];
    
}

- (void)initSearchBar{
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

- (void)initWarningLabel{
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    bgView.backgroundColor = [UIColor whiteColor];
    UILabel *warningL = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 100)/2, (SCREEN_HEIGHT - 40)/2 - 100, 100, 40)];
    warningL.text = @"无结果";
    warningL.font = [UIFont systemFontOfSize:25];
    warningL.textColor = [UIColor grayColor];
    [bgView addSubview:warningL];
    [self.view addSubview:bgView];
    _warningView = bgView;
    _warningView.hidden = YES;
}

#pragma mark - 取消操作
- (void)cancelAction{
    
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



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CityIndexCell getCellHeight];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _searchResults.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CityIndexCell *cell = [CityIndexCell cellWithTableView:tableView];
    cell.cityName = _searchResults[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    [self cancelAction];
    NSString *cityName = _searchResults[indexPath.row];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:kCityButtonClick object:nil userInfo:@{kCityButtonClick : cityName}];
    });
}


#pragma mark - textField字符改变的监听方法UITextFieldDelegate
- (void)textFieldDidChange:(UITextField *)textField{
    NSLog(@"textFiled string = %@",_searchTF.text);
    
    [self searchCityWithText:textField.text];
}

#pragma mark - 匹配关键字
- (void)searchCityWithText:(NSString *)searchText{
    
    _searchResults = [[NSMutableArray alloc]init];

    if (searchText.length > 0 && [ChineseInclude isIncludeChineseInString:searchText]) {//有中文
        
        NSArray *nameArr = [LYCityHandler getAllCityName];
        for (NSString *cName in nameArr) {
            NSRange titleResult=[cName rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (titleResult.length > 0) {
                [_searchResults addObject:cName];
            }
        }
    }else if(searchText.length > 0 && ![ChineseInclude isIncludeChineseInString:searchText]){//英文
        NSArray *nameArr = [LYCityHandler getAllCityName];
        for (NSString *cName in nameArr) {
            if ([ChineseInclude isIncludeChineseInString:cName]) {//有中文
                NSString *tempStr = [PinYinForObjc chineseConvertToPinYinHead:cName];//名字的首字母
                NSRange titleResult=[tempStr rangeOfString:searchText options:NSCaseInsensitiveSearch];
                if (titleResult.length > 0) {
                    [_searchResults addObject:cName];
                }
            }else{//英文
                NSRange titleResult = [cName rangeOfString:searchText options:NSCaseInsensitiveSearch];
                if (titleResult.length > 0) {
                    [_searchResults addObject:cName];
                }
            }
        }
    }
    
    if (_searchResults.count > 0) {
        _warningView.hidden = YES;
    }else{
        _warningView.hidden = NO;
    }
    
    [_tableView reloadData];

}


#pragma mark - scrollView 代理方法
#pragma mark - UIScrollViewDelegate代理
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    [_searchTF resignFirstResponder];
}

@end
