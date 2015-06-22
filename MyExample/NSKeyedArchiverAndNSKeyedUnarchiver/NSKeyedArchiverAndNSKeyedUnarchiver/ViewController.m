//
//  ViewController.m
//  NSKeyedArchiverAndNSKeyedUnarchiver
//
//  Created by qianfeng on 15/6/10.
//  Copyright (c) 2015年 chelongfei. All rights reserved.
//

#import "ViewController.h"
#import "Student.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//       [self initArray];
    [self unarchiveFromPath];
    
}

-(void)initArray
{
    NSArray * nameArray=@[@"老大",@"老二",@"老三",@"老四",@"老小"];
    NSArray * nickNameArray=@[@"1",@"2",@"3",@"4",@"5"];
    NSMutableArray * dataArray_1=[[NSMutableArray alloc]init];
    for (int index=0; index<nameArray.count; index++) {
        Student * stu=[[Student alloc]init];
        stu.name=nameArray[index];
        stu.age=nickNameArray[index];
        [dataArray_1 addObject:stu];
    }
    
    NSMutableArray * dataArray_2=[[NSMutableArray alloc]init];
    for (int index=0; index<nameArray.count; index++) {
        Student * stu=[[Student alloc]init];
        stu.name=nameArray[index];
        stu.age=nickNameArray[index];
        [dataArray_2 addObject:stu];
    }
    NSMutableArray * dataArray=[[NSMutableArray alloc]init];
    [dataArray addObject:dataArray_1];
    [dataArray addObject:dataArray_2];
    //写入文档
    NSString * docPath=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/qf"];
    [NSKeyedArchiver archiveRootObject:dataArray toFile:docPath];
}

//读取文档
-(void)unarchiveFromPath
{
    NSString * docPath=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/qf"];
    NSArray * array=[NSKeyedUnarchiver unarchiveObjectWithFile:docPath];

    for (Student * stu in array[0]) {
        NSLog(@"--%@--%@--",stu.name,stu.age);
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
