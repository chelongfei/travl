//
//  ViewController.m
//  HttpResumDownloadDemo
//
//  Created by qianfeng on 15-5-22.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ViewController.h"
#import "HttpDownloader.h"

#define PROGRESS_TAG @"progress"

#define URL @"http://dlsw.baidu.com/sw-search-sp/soft/2a/25677/QQ_V4.0.0.1419920162.dmg"

@interface ViewController ()<HttpDownloadProgressDelegate>
@property(nonatomic)UIProgressView *progressView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    
    //更新保存的进度
    NSNumber *number = [[NSUserDefaults standardUserDefaults] objectForKey:PROGRESS_TAG];
    self.progressView.progress = [number floatValue];
}

-(void)createUI
{
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    startBtn.frame = CGRectMake(50, 64, 80, 40);
    [startBtn setTitle:@"start" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startDownload:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];
    
    
    UIButton *stopBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    stopBtn.frame = CGRectMake(250, 64, 80, 40);
    [stopBtn setTitle:@"stop" forState:UIControlStateNormal];
    [stopBtn addTarget:self action:@selector(stopDownload:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopBtn];

    self.progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(80, 200, 250, 30)];
    [self.view addSubview:self.progressView];
}

-(void)startDownload:(UIButton*)button
{
    if (self.progressView.progress == 1.0) {
        return;
    }
    
    //开始下载
    [[HttpDownloader sharedInstance] start:URL];
    
    //设置代理，更新进度
    [HttpDownloader sharedInstance].delegate = self;
}

-(void)stopDownload:(UIButton*)button
{
    [[HttpDownloader sharedInstance] stop];
}

#pragma mark -
#pragma mark delegate
-(void)httpDownloader:(HttpDownloader*)download dowloadSize:(unsigned long long)downloadSize totalSize:(unsigned long long)totalSize
{
    float progress = downloadSize/(totalSize*1.0);
    self.progressView.progress = progress;
    NSLog(@"progress = %f",self.progressView.progress);
    
    //时时保存下载的进度
    [[NSUserDefaults standardUserDefaults] setValue:@(progress) forKey:PROGRESS_TAG];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)httpDownloader:(HttpDownloader *)download dowloadComplete:(BOOL)flag
{
    self.progressView.progress = 1.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
