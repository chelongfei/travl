//
//  DetailViewController.m
//  Travel
//
//  Created by qianfeng on 15/6/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DetailViewController.h"
#import <WebKit/WebKit.h>
#import "SVProgressHUD.h"

@interface DetailViewController ()<WKNavigationDelegate>

@property(nonatomic)WKWebView * webView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor orangeColor];
    self.webView=[[WKWebView alloc]initWithFrame:(CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))];
    self.webView.navigationDelegate=self;
    NSURLRequest * request=[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:_url]];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
     [SVProgressHUD showWithStatus:@"努力加载中"];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [SVProgressHUD showSuccessWithStatus:@"加载完成"];
}



@end
