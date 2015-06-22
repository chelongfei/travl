//
//  Employer.h
//  CoreData4
//
//  Created by qianfeng on 15-6-10.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Department;

@interface Employer : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSString * identify;
@property (nonatomic, retain) Department *relationship;

@end
