//
//  OAuthViewController.m
//  DoubanWorlds
//
//  Created by LYoung on 16/1/4.
//  Copyright © 2016年 LYoung. All rights reserved.
//

#import "OAuthViewController.h"
#import "AccountTool.h"


@interface OAuthViewController ()<NSURLConnectionDelegate,UIWebViewDelegate>

{
    UIWebView *_webView;
}

@end

@implementation OAuthViewController

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUDManager dismiss];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSURL *url = [NSURL URLWithString:OAuth_URL];
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];

}
- (void)loadView
{
    _webView = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame];
    _webView.delegate = self;
    self.view = _webView;
}


#pragma mark webView delegate
/**
 *  开始请求时调用
 */
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    //弹框
    [SVProgressHUDManager showWithStatus:@"加载中..."];
    
}
/**
 *  开始请求完成调用
 */
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUDManager dismiss];
}

/**
 *  webView每发送一次请求,就会调用
 *
 *  @param webView        是那个webView法的请求
 *  @param request        发送的时怎样的请求
 *
 *  @return YES:可以发送请求 NO:不可以发送请求
 */
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"%@",request.URL);
    //1.获得请求路径
    NSString *urlString = request.URL.absoluteString;
    //2.获得code=在请求路径中得范围
    NSRange range = [urlString rangeOfString:@"code="];
    //3.能找到code=
    if (range.location != NSNotFound) {
        //开始截取的位置
        NSInteger fromIndex = range.length + range.location;
        //截取code=后面的值
        NSString *code = [urlString substringFromIndex:fromIndex];
        NSLog(@"code = %@",code);
        
        //根据code获得用户的accessToken
        [AccountTool getAccessTokenWithcode:code success:^{
            
            NSLog(@"SUCCESS--- - - -");
            [self.navigationController popViewControllerAnimated:YES];
            
            
        } filure:nil];
        
        //3.请求终止
        return NO;
    }else
        return YES;
}




@end
