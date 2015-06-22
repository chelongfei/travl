//
//  Person.h
//  MagicalRecordDemo
//
//  Created by 愤怒的振振 on 15-5-9.
//  Copyright (c) 2015年 LiuWeiZhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Person : NSManagedObject

@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSString * firstname;
@property (nonatomic, retain) NSString * lastname;

@end
