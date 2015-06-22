//
//  WebViewController.m
//  TestOpenUrl
//
//  Created by qianfeng on 15/6/20.
//  Copyright (c) 2015年 chelongfei. All rights reserved.
//&key=99e3d94c53443823264e74d2ade13f37

#import "WebViewController.h"
#import <WebKit/WebKit.h>

@interface WebViewController ()

@property(nonatomic)WKWebView * webView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    self.webView=[[WKWebView alloc]initWithFrame:CGRectMake(0,64, self.view.frame.size.width, self.view.frame.size.height-64)];
//    使用场景一：仅使用标注功能（目前支持单个点标注）
//    使用参数：dest=()&destName=()&hideRouteIcon=1
        NSURLRequest * request=[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"http://m.amap.com/navi?dest=131.234527,121.287689&destName=parameter2&hideRouteIcon=1&key=99e3d94c53443823264e74d2ade13f37"]];
//    使用场景二：从标点到路线规划完成
//    使用参数：start=()&dest=()&destName=()
//    使用场景三：仅路线
//    使用参数：start=()&dest=()&naviBy=()

    
    
    //定位到某一点
//    NSURLRequest * request=[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"http://mo.amap.com/?q=31.234527,   121.287689&name=park&dev=0"]];
    
    //
//    NSURLRequest * request=[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"http://m.amap.com/navi?start=&dest=22.198746,113.543877&destName=parameter2&key=99e3d94c53443823264e74d2ade13f37"]];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
