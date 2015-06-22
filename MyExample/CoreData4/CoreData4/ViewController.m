//
//  ViewController.m
//  CoreData4
//
//  Created by qianfeng on 15-6-10.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>

#import "Employer.h"
#import "Department.h"

#define DEPART_ENTRY_NAME    @"Department"
#define EMPLOYER_ENTRY_NAME  @"Employer"
#define TABLEVIEW_ID         @"cellId"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate>
@property(nonatomic)NSManagedObjectContext *context;
@property(nonatomic)NSFetchedResultsController *fectchedController;


@property(nonatomic)UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    self.context = delegate.managedObjectContext;
    
    [self addCustomData];
    

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:TABLEVIEW_ID];
    
    [self.fectchController performFetch:nil];
    [self.tableView reloadData];
}

-(void)fetchRequest
{
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:[NSEntityDescription entityForName:DEPART_ENTRY_NAME inManagedObjectContext:self.context]];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]initWithKey:@"name" ascending:YES];
    request.sortDescriptors = @[sort];
    NSArray *array = [self.context executeFetchRequest:request error:nil];
    for (Department *dep in array) {
        NSLog(@"dep -- %@",dep.name);
        NSSet *employerArray = dep.relationship;
        for (Employer *employer in employerArray) {
            NSLog(@"employer --%@",employer.name);
        }
    }
}

-(void)addCustomData
{
    for (int index = 0; index < 5; index++) {
        Department *dep1 = [NSEntityDescription insertNewObjectForEntityForName:DEPART_ENTRY_NAME inManagedObjectContext:self.context];
        dep1.name = [NSString stringWithFormat:@"%d",index];
        dep1.floor = @(index);
    }
    
    [self.context save:nil];
    
    //--------1-------------
//    Department *dep1 = [NSEntityDescription insertNewObjectForEntityForName:DEPART_ENTRY_NAME inManagedObjectContext:self.context];
//    
//    dep1.floor = @(1);
//    dep1.name  = @"1";
//    
//    Employer *p11 = [NSEntityDescription insertNewObjectForEntityForName:EMPLOYER_ENTRY_NAME inManagedObjectContext:self.context];
//    p11.name = @"--11";
//    p11.identify = @"--11";
//    
//    [dep1 addRelationshipObject:p11];
//    
//    Employer *p12 = [NSEntityDescription insertNewObjectForEntityForName:EMPLOYER_ENTRY_NAME inManagedObjectContext:self.context];
//    p12.name = @"--1111";
//    p12.identify = @"--1111";
//    
//    [dep1 addRelationshipObject:p12];
//    
//    //-----------2-----------
//    
//    
//    Department *dep2 = [NSEntityDescription insertNewObjectForEntityForName:DEPART_ENTRY_NAME inManagedObjectContext:self.context];
//    
//    dep2.floor = @(2);
//    dep2.name  = @"2";
//    
//    Employer *p21 = [NSEntityDescription insertNewObjectForEntityForName:EMPLOYER_ENTRY_NAME inManagedObjectContext:self.context];
//    p21.name = @"--22";
//    p21.identify = @"--22";
//    
//    [dep2 addRelationshipObject:p21];
//    
//    Employer *p22 = [NSEntityDescription insertNewObjectForEntityForName:EMPLOYER_ENTRY_NAME inManagedObjectContext:self.context];
//    p22.name = @"--2222";
//    p22.identify = @"--2222";
//    
//    [dep2 addRelationshipObject:p22];
//    
//    [self.context save:nil];
}

-(UITableView*)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
        _tableView.dataSource = self;
        _tableView.delegate   = self;
        [self.view addSubview:_tableView];
    }

    return _tableView;
}

-(NSFetchedResultsController*)fectchController
{
//    if (_fectchController == nil) {
//        NSFetchRequest *request = [[NSFetchRequest alloc]init];
//        [request setEntity:[NSEntityDescription entityForName:DEPART_ENTRY_NAME inManagedObjectContext:self.context]];
//        NSSortDescriptor *sort = [[NSSortDescriptor alloc]initWithKey:@"name" ascending:YES];
//        request.sortDescriptors = @[sort];
//        
//        _fectchController = [[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:self.context sectionNameKeyPath:@"name" cacheName:nil];
//    }
//    return _fectchController;
    
    if (_fectchedController == nil) {
        NSFetchRequest *request = [[NSFetchRequest alloc]init];
        [request setEntity:[NSEntityDescription entityForName:@"Department" inManagedObjectContext:self.context]];
        NSSortDescriptor *sort = [[NSSortDescriptor alloc]initWithKey:@"name" ascending:YES];
        request.sortDescriptors = @[sort];
        
        _fectchedController = [[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:self.context sectionNameKeyPath:@"name" cacheName:nil];
        _fectchedController.delegate = self;
    }
    return _fectchedController;
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSArray *sectionArray = [self.fectchController sections];
    return [sectionArray count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([[self.fectchController sections] count] > 0) {
        id<NSFetchedResultsSectionInfo> sectionInfo = [[self.fectchController sections]objectAtIndex:section];
        return [sectionInfo numberOfObjects];
    }
    return 0;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    id<NSFetchedResultsSectionInfo> sectionInfo = [[self.fectchController sections]objectAtIndex:section];
    return sectionInfo.name;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:TABLEVIEW_ID];
    Department *dep = [self.fectchController objectAtIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%d",[dep.floor integerValue]];
//    id<NSFetchedResultsSectionInfo> sectionInfo = [[self.fectchController sections]objectAtIndex:indexPath.section];
//    NSArray *object = sectionInfo.objects;
//    Employer *p = [object objectAtIndex:indexPath.row];
//    cell.textLabel.text = p.name;
    return cell;
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
