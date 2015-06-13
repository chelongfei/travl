//
//  DesCountryController.m
//  Travel
//
//  Created by qianfeng on 15/6/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DesCountryController.h"
#import "DataEngine.h"
#import "AnalyticalNetWorkData.h"

@interface DesCountryController ()

//数组中四个小数组,第一个(一个对象)是model,第二个是hotCountrty数组
//第三个是disCount数组,第四个是trip数组
@property(nonatomic)NSMutableArray * dataArray;

@end

@implementation DesCountryController

- (void)viewDidLoad {
    [super viewDidLoad];
   [self fetchDataWithUrl];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
    
}

-(void)fetchDataWithUrl
{
    [[DataEngine shareInstance]requestDestinationDetailDataWithCityID:self.model.id success:^(NSData *respondsObject) {
        self.dataArray=[AnalyticalNetWorkData parseDestinationDetailData:respondsObject];
        NSLog(@"%ld",self.dataArray.count);
        
    } faild:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
