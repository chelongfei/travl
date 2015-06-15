//
//  CircleButtonController.m
//  Travel
//
//  Created by qianfeng on 15/6/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CircleButtonController.h"
#import "CircleButtonCell.h"
#import "DataEngine.h"
#import "AnalyticalNetWorkData.h"
#import "TypeModel.h"
#import "EntryModel.h"


#define TBL_CELL_ID @"tableViewCellId"


@interface CircleButtonController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic)UITableView * tableView;
@property(nonatomic)NSMutableArray * entryArray;
@property(nonatomic)NSMutableArray * typeArray;


@end

@implementation CircleButtonController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTableView];
    [self fetchDataWithUrl];
}


-(void)addTableView
{
    self.tableView=[[UITableView alloc]initWithFrame:self.view.frame];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.tableView registerClass:[CircleButtonCell class] forCellReuseIdentifier:TBL_CELL_ID];
    [self.view addSubview:self.tableView];
}

-(void)fetchDataWithUrl
{
    [[DataEngine shareInstance]requestDetailCityCricleButtonWithCategoryId:self.categoryID success:^(NSData *respondsObject) {
        NSMutableArray * tempArray=[AnalyticalNetWorkData parseDetailCityCircleButtonData:respondsObject];
        self.typeArray=tempArray[0];
        self.entryArray=tempArray[1];
        [self.tableView reloadData];
    } faile:^(NSError *error) {
        
    }];
}

#pragma mark-----懒加载

-(NSMutableArray *)typeArray
{
    if (_typeArray==nil) {
        _typeArray=[[NSMutableArray alloc]init];
    }
    return _typeArray;
}

-(NSMutableArray *)entryArray
{
    if (_entryArray==nil) {
        _entryArray=[[NSMutableArray alloc]init];
    }
    return _entryArray;
}

#pragma mark ---<UITableViewDataSource,UITableViewDelegate>

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.entryArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CircleButtonCell * cell=[self.tableView dequeueReusableCellWithIdentifier:TBL_CELL_ID forIndexPath:indexPath];
    EntryModel * model=[self.entryArray objectAtIndex:indexPath.row];
    cell.textLabel.text=model.firstname;
    
    return cell;
}

@end
