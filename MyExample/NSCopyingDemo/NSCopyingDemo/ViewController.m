//
//  ViewController.m
//  NSCopyingDemo
//
//  Created by qianfeng on 15/1/12.
//  Copyright (c) 2015年 chelongfei. All rights reserved.
//

#import "ViewController.h"
#import "TestObject.h"

@interface ViewController ()

@property(nonatomic,copy)NSString * str;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    NSString * str=@"abc";
    //    NSString * strCopy=str.copy;
    //
    //    //对于不可变对象,copy是指针复制,由于不可变,系统底层优化
    //    NSLog(@"%p,%p",str,strCopy);
    //
    //    NSMutableString * str2=[[NSMutableString alloc]initWithString:@"abc"];
    //    //copy返回的是不可变的对象,所以返回的结果不能修改
    //    NSMutableString * str2Copy=str2.copy;
    //
    //    [str2Copy appendString:@"1503"];
    //
    //    //str2Copy为不可变对象
    //    NSLog(@"%p,%p",str2,str2Copy);
    //
    //     //mutableCopy返回的结果可以修改
    //    NSMutableString * str2MCopy=str2.mutableCopy;
    //    [str2MCopy appendString:@"1503"];
    
    
    //对于自己生成的对象,默认不遵循NSCopying协议
    TestObject * t1=[[TestObject alloc]init];
    TestObject * t2=t1.copy;
    //     NSLog(@"%p-----str,%p",t1,t1.str);
    //    NSLog(@"%p-----str,%p",t2,t2.str);
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
