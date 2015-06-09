//
//  RecommedView.m
//  Travel
//
//  Created by qianfeng on 15/6/3.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "RecommendView.h"
#import "RecommendHeadView.h"

@interface RecommendView ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property(nonatomic)RecommendHeadView * recommendHeadView;
@property(nonatomic)NSMutableArray * dataArray;
@property(nonatomic)NSInteger currentPage;

@end

@implementation RecommendView

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        self.currentPage=0;
        
        self.dataArray=[NSMutableArray array];
        
        self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-80)];
        self.tableView.dataSource=self;
        self.tableView.delegate=self;
        [self addHeadView];
    }
    return self;
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
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark---Tough

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    float height = scrollView.contentSize.height > _tableView.frame.size.height ?_tableView.frame.size.height : scrollView.contentSize.height;
    if ((height - scrollView.contentSize.height + scrollView.contentOffset.y) / height > 0.1) {
        NSLog(@"我要刷新了啊");
        self.currentPage++;
        // 调用上拉刷新方法
    }
}

@end
