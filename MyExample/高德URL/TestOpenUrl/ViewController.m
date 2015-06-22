//
//  ViewController.m
//  TestOpenUrl
//
//  Created by qianfeng on 15/6/20.
//  Copyright (c) 2015年 chelongfei. All rights reserved.
//&key=99e3d94c53443823264e74d2ade13f37

#import "ViewController.h"
#import "WebViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}
- (IBAction)click:(UIButton *)sender {
   WebViewController * VC=[[WebViewController alloc]init];
//    [self presentViewController:VC animated:YES completion:nil];
   [self.navigationController pushViewController:VC animated:YES];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
