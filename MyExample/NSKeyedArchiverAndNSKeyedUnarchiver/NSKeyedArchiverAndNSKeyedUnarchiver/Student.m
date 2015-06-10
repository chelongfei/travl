//
//  Student.m
//  NSKeyedArchiverAndNSKeyedUnarchiver
//
//  Created by qianfeng on 15/6/10.
//  Copyright (c) 2015年 chelongfei. All rights reserved.
//

#import "Student.h"

@implementation Student


-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"myName"];
    [aCoder encodeObject:self.age forKey:@"myAge"];
    
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super init]) {
        self.name=[aDecoder decodeObjectForKey:@"myName"];
        self.age=[aDecoder decodeObjectForKey:@"myAge"];
    }
    return self;
}

@end
