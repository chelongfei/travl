//
//  CustomNavBarController.m
//  Travel
//
//  Created by qianfeng on 15/6/16.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CustomNavBarController.h"
#import "MapViewController.h"

@interface CustomNavBarController ()

@end

@implementation CustomNavBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCustomNavgationBar];
}

-(void)addCustomNavgationBar
{
  self.view.backgroundColor=[UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    self.navigationController.navigationBarHidden=YES;
    
    self.bar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20,self.view.frame.size.width, 50)];
    
    self.bar.barTintColor=[UIColor purpleColor];
    
    UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:nil];
    
    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [left setFrame:CGRectMake(0, 10, 30, 30)];
    
    [left setImage:[UIImage imageNamed:@"ic_back_white.png"] forState:(UIControlStateNormal)];
    
    [left addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:left];

    [item setLeftBarButtonItem:leftButton];
    
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [right setFrame:CGRectMake(self.view.frame.size.width-50, 10, 30, 30)];
    
    [right setImage:[UIImage imageNamed:@"ic_map_white.png"] forState:(UIControlStateNormal)];
    
    [right addTarget:self action:@selector(map:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:right];
    
    [item setRightBarButtonItem:rightButton];
    
    [self.bar pushNavigationItem:item animated:NO];
    
    [self.view addSubview:self.bar];
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)map:(UIButton *)button
{
    MapViewController * mapVC=[[MapViewController alloc]init];
    mapVC.categoryID=self.categoryID;
    mapVC.cityID=self.cityID;
    [self.navigationController pushViewController:mapVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
