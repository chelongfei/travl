//
//  TestObject.h
//  NSCopyingDemo
//
//  Created by qianfeng on 15/6/12.
//  Copyright (c) 2015年 chelongfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestObject : NSObject<NSCopying>

@property(nonatomic,copy)NSMutableString * str;

@end
