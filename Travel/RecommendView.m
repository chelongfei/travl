//
//  RecommedView.m
//  Travel
//
//  Created by qianfeng on 15/6/3.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "RecommendView.h"
#import "RecommendHeadView.h"
#import "DataEngine.h"
#import "RecommendCellModel.h"
#import "AnalyticalNetWorkData.h"
#import "RecommendTVCell.h"

#define TBL_VIWE_CELLID @"tableViewCellID"

@interface RecommendView ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property(nonatomic)RecommendHeadView * recommendHeadView;
@property(nonatomic)NSMutableArray * dataArray;
@property(nonatomic)NSInteger currentPage;
@property(nonatomic)NSMutableArray * tableDataArray;
@property(nonatomic)BOOL isLoading;

@end

@implementation RecommendView

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        self.currentPage=0;
        
        _isLoading=NO;
        
        self.dataArray=[NSMutableArray array];
        
        self.tableDataArray=[NSMutableArray array];
        
        [self addTabelViewWithFrame:frame];
        
    }
    return self;
}

-(void)addTabelViewWithFrame:(CGRect)frame
{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-80)];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    UINib * nib=[UINib nibWithNibName:@"RecommendTVCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:TBL_VIWE_CELLID];
    [self addHeadView];
}

//接收数据更新UI
-(void)updateHeadView:(NSMutableArray *)dataArray
{
    [_recommendHeadView updateRecommendHeadView:dataArray];
}

//添加tableView的头视图
-(void)addHeadView
{
    UINib * nib=[UINib nibWithNibName:@"RecommendHeadView" bundle:nil];
    NSArray * array=[nib instantiateWithOwner:nil options:nil];
    _recommendHeadView=[array lastObject];
    _tableView.tableHeaderView=_recommendHeadView;
    [self addSubview:_tableView];
}



#pragma mark---<UITableViewDataSource,UITableViewDelegate>

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableDataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecommendTVCell * cell=[self.tableView dequeueReusableCellWithIdentifier:TBL_VIWE_CELLID forIndexPath:indexPath];
    RecommendCellModel * model=[self.tableDataArray objectAtIndex:indexPath.row];
    [cell updateCellWithModel:model];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecommendCellModel * model=[self.tableDataArray objectAtIndex:indexPath.row];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"recommendCellClick" object:model];
}

#pragma mark---上拉刷新

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    float height = scrollView.contentSize.height > _tableView.frame.size.height ?_tableView.frame.size.height : scrollView.contentSize.height;
    if (_isLoading==NO) {
        
        if ((height - scrollView.contentSize.height + scrollView.contentOffset.y) / height > 0.1) {
            NSLog(@"我要刷新了啊");
            _isLoading=YES;
            self.currentPage++;
            // 调用上拉刷新方法
            [self refreshCell];
        }
        _isLoading=NO;
    }
}

-(void)refreshCell
{
    [[DataEngine shareInstance]requestRecommendCellDataWithPage:self.currentPage success:^(NSData *respondsObject) {
        NSArray * temArray=[AnalyticalNetWorkData parseRecommendCell:respondsObject];
        for (RecommendCellModel * model in temArray) {
            [self.tableDataArray addObject:model];
        }
        [self.tableView reloadData];
    } faild:^(NSError *error) {
        
    }];
}

@end
