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
#import "CircleButtonCell.h"
#import "ViewController.h"

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
    [self addBottomView];
    [self fetchDataWithUrl];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    switch ([self.categoryID integerValue]) {
        case 32:
            self.navigationController.navigationBar.backgroundColor=[UIColor colorWithRed:194/255.0 green:124/255.0 blue:208/255.0 alpha:1.0];
            break;
        
        case 78:
            
            break;
        case 147:
            
            break;
        case 148:
            
            break;
        default:
            break;
    }
}

-(void)addTableView
{
    self.tableView=[[UITableView alloc]initWithFrame:self.view.frame];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    UINib * nib=[UINib nibWithNibName:@"CircleButtonCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:TBL_CELL_ID];
    
    [self.view addSubview:self.tableView];
}

-(void)addBottomView
{
    
}

-(void)fetchDataWithUrl
{
    [[DataEngine shareInstance]requestDetailCityCricleButtonWithCategoryId:self.categoryID cityID:self.cityID success:^(NSData *respondsObject) {
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.entryArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CircleButtonCell * cell=[self.tableView dequeueReusableCellWithIdentifier:TBL_CELL_ID forIndexPath:indexPath];
    EntryModel * model=[self.entryArray objectAtIndex:indexPath.row];
    [cell initUIWithModel:model];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

@end
