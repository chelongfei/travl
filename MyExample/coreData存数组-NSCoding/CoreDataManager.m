//
//  CoreDataManager.m
//  Travel
//
//  Created by qianfeng on 15/6/10.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CoreDataManager.h"
#import "Entity.h"
#import "student.h"

@interface CoreDataManager()

{
    NSManagedObjectContext * _context;
}

@end



@implementation CoreDataManager


-(void)perple
{
    NSString * momdPath=[[NSBundle mainBundle]pathForResource:@"Model" ofType:@"momd"];
    NSManagedObjectModel * model=[[NSManagedObjectModel alloc]initWithContentsOfURL:[NSURL URLWithString:momdPath]];
    NSPersistentStoreCoordinator * coordinator=[[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:model];
    
    NSString *dbPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Entity.sqlite"];
    NSError *error   = nil;

    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:dbPath] options:nil error:&error];
    _context=[[NSManagedObjectContext alloc]init];
    _context.persistentStoreCoordinator=coordinator;
}

+(instancetype)defaultCoreManager
{
    static CoreDataManager * s_coreDataManager=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_coreDataManager=[[CoreDataManager alloc]init];
        [s_coreDataManager perple];
    });
    return s_coreDataManager;
}

-(void)addModelFromNetWork:(NSArray *)array
{
    Entity * entity=[NSEntityDescription insertNewObjectForEntityForName:@"Entity" inManagedObjectContext:_context];
    NSData * archiveCarPriceData=[NSKeyedArchiver archivedDataWithRootObject:array];
    entity.dataArray=archiveCarPriceData;
    [_context save:nil];
    
}

-(void)fetchModelFromCoreData
{
    NSFetchRequest * fetchRequest=[NSFetchRequest fetchRequestWithEntityName:@"Entity"];
    NSArray * array=[_context executeFetchRequest:fetchRequest error:nil];
    if (array==0) {
        return ;
    }
    for (Entity * model in array) {
        //解归档的前提是拥有相关的类。
        NSArray * array=[NSKeyedUnarchiver unarchiveObjectWithData:model.dataArray];
        student * stu=[array objectAtIndex:1];
        NSLog(@"%@",stu.name);

    }

    
}

-(void)removeAllModelFromCoreData
{
    
    
}

@end
