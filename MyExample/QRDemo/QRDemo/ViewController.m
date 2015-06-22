//
//  ViewController.m
//  QRDemo
//
//  Created by qianfeng on 15-5-28.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ViewController.h"
#import "QRCodeGenerator.h"
#import "ScanQRViewController.h"



//提取照片和视频的库
//#import <AssetsLibrary/AssetsLibrary.h>

@interface ViewController ()
@property(nonatomic)UIImageView *qrImageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.qrImageView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 100, 200, 200)];
    UIImage *image = [QRCodeGenerator qrImageForString:@"其实我是个演员" imageSize:200];
    self.qrImageView.image = image;
    [self.view addSubview:self.qrImageView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(50, 350, 100, 40);
    [button setTitle:@"扫描二维码" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(scanQR) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void)scanQR
{
    ScanQRViewController *scanQRVC = [[ScanQRViewController alloc]init];
    [self presentViewController:scanQRVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
