//
//  student.m
//  TestArchi
//
//  Created by qianfeng on 15/6/10.
//  Copyright (c) 2015年 chelongfei. All rights reserved.
//

#import "student.h"

@implementation student


-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.nickName forKey:@"nickName"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super init]) {
        self.name =[aDecoder decodeObjectForKey:@"name"];
        self.nickName=[aDecoder decodeObjectForKey:@"nickName"];
    }
    return self;
}

@end
