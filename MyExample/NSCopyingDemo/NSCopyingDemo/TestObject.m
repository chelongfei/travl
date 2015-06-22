//
//  TestObject.m
//  NSCopyingDemo
//
//  Created by qianfeng on 15/6/12.
//  Copyright (c) 2015年 chelongfei. All rights reserved.
//

#import "TestObject.h"

@implementation TestObject

-(id)init
{
    //super init 有可能重新生成对象,所以要重新对self赋值
    if (self=[super init]) {
        _str=[[NSMutableString alloc]initWithString:@""];
    }
    return self;
}


//实现NSCopying协议的方法
//zone对ios无效
//zone参数是新对象将分配到的内存区，一般不用修改。
//copyWithZone
//1.生成新的对象
//2.把被copy对象的值传递过去
- (id)copyWithZone:(NSZone *)zone
{
    TestObject * newObject=[TestObject allocWithZone:zone];
    
    
    //如果@property中为retain,strong
    //这种copy称为浅copy,因为str指向的是同一个对象,str没有进行copy操作
    newObject.str=self.str;
    
    //如果@property中为copy
    //由于newObject.str和self.str指向的是 不同的对象,所以说为深copy
    
    return newObject;
}

@end
