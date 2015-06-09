//
//  CollectViewController.m
//  DailyNews
//
//  Created by qianfeng on 15/6/9.
//  Copyright (c) 2015年 chelongfei. All rights reserved.
//

#import "CollectViewController.h"
#import "CollectModel.h"

#define TBL_CELL_ID @"cellID"

@interface CollectViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic)UITableView * tableView;
@property(nonatomic)NSArray * dataArray;

@end

@implementation CollectViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
    
}

-(id)init
{
    if (self=[super init]) {
        [self addTableView];
    }
    return self;
}

-(void)addTableView
{
    self.tableView=[[UITableView alloc]initWithFrame:self.view.frame];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:TBL_CELL_ID];
    [self.view addSubview:self.tableView];
}


-(void)updateTableCellWithArray:(NSArray *)array
{
    self.dataArray=[[NSArray alloc]init];
    self.dataArray=array;
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-----<UITableViewDataSource,UITableViewDelegate>

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  [self.dataArray count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell=[self.tableView dequeueReusableCellWithIdentifier:TBL_CELL_ID];
    CollectModel * model=[ self.dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text=model.content;
    return cell;
}

@end
