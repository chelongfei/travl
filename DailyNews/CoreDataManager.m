//
//  CoreDataManager.m
//  DailyNews
//
//  Created by qianfeng on 15/6/9.
//  Copyright (c) 2015年 chelongfei. All rights reserved.
//

#import "CoreDataManager.h"


@interface CoreDataManager()
{
    NSManagedObjectContext * _context;
}
@end

@implementation CoreDataManager

-(id)init
{
    if (self=[super init]) {
        NSString * modelPath=[[NSBundle mainBundle] pathForResource:@"CollectModel" ofType:@"momd"];
        NSManagedObjectModel * model=[[NSManagedObjectModel alloc]initWithContentsOfURL:[NSURL URLWithString:modelPath]];
        NSPersistentStoreCoordinator * coordinator=[[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:model];
        //
        NSString *path = [NSHomeDirectory()   stringByAppendingString:@"/Documents/MyCollect.sqlite"];
        NSPersistentStore * store=[coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:path] options:nil error:nil];
        _context=[[NSManagedObjectContext alloc]init];
        _context.persistentStoreCoordinator=coordinator;
    }
    return self;
}


+(instancetype)defaultManager
{
    static CoreDataManager * s_manager=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_manager=[[CoreDataManager alloc]init];
    });
    return s_manager;
}

-(void)addModelToCoreData:(DataModel *)dataModel
{
    NSFetchRequest * request=[NSFetchRequest fetchRequestWithEntityName:@"MyCollect"];
    NSArray * arr=[_context executeFetchRequest:request error:nil];
    for (CollectModel * model in arr) {
        if ([model.content isEqualToString: dataModel.content]) {
            return;
        }
    }
    CollectModel * model=[NSEntityDescription insertNewObjectForEntityForName:@"MyCollect" inManagedObjectContext:_context];

    model.title=dataModel.title;
    model.content=dataModel.content;
    [_context save:nil];
}

-(NSArray *)fetchModelToUpdateUI
{
    NSFetchRequest * request=[NSFetchRequest fetchRequestWithEntityName:@"MyCollect"];
    NSArray * arr=[_context executeFetchRequest:request error:nil];
    return arr;
}


@end
