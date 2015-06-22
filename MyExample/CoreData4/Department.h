//
//  Department.h
//  CoreData4
//
//  Created by qianfeng on 15-6-10.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Employer;

@interface Department : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * floor;
@property (nonatomic, retain) NSSet *relationship;
@end

@interface Department (CoreDataGeneratedAccessors)

- (void)addRelationshipObject:(Employer *)value;
- (void)removeRelationshipObject:(Employer *)value;
- (void)addRelationship:(NSSet *)values;
- (void)removeRelationship:(NSSet *)values;

@end
