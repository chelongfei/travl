//
//  CoreDataManager.h
//  DailyNews
//
//  Created by qianfeng on 15/6/9.
//  Copyright (c) 2015年 chelongfei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "CollectModel.h"
#import "DataModel.h"

@interface CoreDataManager : NSObject

+(instancetype)defaultManager;

-(void)addModelToCoreData:(DataModel *)dataModel;

-(NSArray *)fetchModelToUpdateUI;

@end
