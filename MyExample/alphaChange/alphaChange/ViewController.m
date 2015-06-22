//
//  ViewController.m
//  alphaChange
//
//  Created by qianfeng on 15/6/11.
//  Copyright (c) 2015年 chelongfei. All rights reserved.
//

#import "ViewController.h"

#define TBL_VIEW_CELLID  @"tableViewCellID"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property(nonatomic)UITableView * tableView;
@property(nonatomic)UIView * headView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addHeadView];
    [self addTableView];
}

-(void)addHeadView
{
    self.headView=[[UIView alloc]initWithFrame:(CGRectMake(0, 0, self.view.frame.size.width, 40))];
    self.headView.backgroundColor=[UIColor greenColor];
    self.headView.alpha=0;
    [self.view addSubview:self.headView];
}

-(void)addTableView
{
    self.tableView=[[UITableView alloc]initWithFrame:(CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height-40)) style:(UITableViewStylePlain)];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:TBL_VIEW_CELLID];
    [self.view addSubview:self.tableView];
}

#pragma mark-----<UITableViewDataSource,UITableViewDelegate>
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell=[self.tableView dequeueReusableCellWithIdentifier:TBL_VIEW_CELLID forIndexPath:indexPath];
    cell.textLabel.text=[NSString stringWithFormat:@"行数%ld",indexPath.row];
    return cell;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  =----<UIScrollViewDelegate>

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.headView.alpha=self.tableView.contentOffset.y/500;
    
}

@end
