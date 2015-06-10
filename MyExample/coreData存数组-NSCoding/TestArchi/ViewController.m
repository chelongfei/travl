//
//  ViewController.m
//  TestArchi
//
//  Created by qianfeng on 15/6/10.
//  Copyright (c) 2015年 chelongfei. All rights reserved.
//

#import "ViewController.h"
#import "student.h"
#import "CoreDataManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self initArray];
    [[CoreDataManager defaultCoreManager]fetchModelFromCoreData];
   
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)initArray
{
    NSArray * nameArray=@[@"老大",@"老二",@"老三",@"老四",@"老小"];
    NSArray * nickNameArray=@[@"大",@"二",@"三",@"四",@"小"];
    NSMutableArray * dataArray=[[NSMutableArray alloc]init];
    for (int index=0; index<nameArray.count; index++) {
        student * stu=[[student alloc]init];
        stu.name=nameArray[index];
        stu.nickName=nickNameArray[index];
        [dataArray addObject:stu];
    }
     [[CoreDataManager defaultCoreManager]addModelFromNetWork:dataArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
