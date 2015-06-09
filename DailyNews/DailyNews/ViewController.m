//
//  ViewController.m
//  DailyNews
//
//  Created by qianfeng on 15/6/6.
//  Copyright (c) 2015年 chelongfei. All rights reserved.
//


#import "ViewController.h"
#import "DataEngine.h"
#import "AnalyseNetData.h"
#import "MyCollectionViewCell.h"
#import "DataModel.h"
#import "TopView.h"
#import "BottomView.h"
#import "SettingViewController.h"
#import "MapViewController.h"
#import "ListViewController.h"
#import "CollectViewController.h"
#import "CoreDataManager.h"

#define SCREEN_WIDTH  self.view.frame.size.width
#define SCREEN_HEIGHT self.view.frame.size.height
#define MYCOLLECTIONVIEW_CELL_ID @"myCollectionViewCellId"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic)UICollectionView * collectionView;
@property(nonatomic)NSMutableArray * dataArray;
@property(nonatomic)TopView * topView;
@property(nonatomic)BottomView * bottomView;
@property(nonatomic)UIButton * mapButton;
@property(nonatomic)UIButton * picButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addStatusBarView];
    [self addCollectionView];
    [self addTopView];
    [self addBottomView];
    [self loadDataFormNet];
}

#pragma mark ----dealloc
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setting) name:@"setting" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushToCollectionVC:) name:@"myCollect" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(IWantCollect) name:@"IWantCollect" object:nil];
    
}

-(void)setting
{
    SettingViewController * VC=[[SettingViewController alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
}

-(void)pushToCollectionVC:(NSNotification *)notify
{
    CollectViewController * collectVC=[[CollectViewController alloc]init];
    NSArray * array=(NSArray *)notify.object;
    [collectVC updateTableCellWithArray:array];
    [self.navigationController pushViewController:collectVC animated:YES];
}

-(void)IWantCollect
{
    NSInteger index=self.collectionView.contentOffset.x/self.view.frame.size.width;
    if (self.dataArray.count<index||self.dataArray==0) {
        return;
    }
    DataModel * model=[self.dataArray objectAtIndex:index];
    [[CoreDataManager defaultManager] addModelToCoreData:model];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)addStatusBarView
{
    UIView * view=[[UIView alloc]initWithFrame:(CGRectMake(0, 0, self.view.frame.size.width, 20))];
    view.backgroundColor=[UIColor blackColor];
    [self.view addSubview:view];
}

-(void)addCollectionView
{
    UICollectionViewFlowLayout * flowLayout=[[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize=CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-120);
    flowLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumInteritemSpacing=0;
    flowLayout.minimumLineSpacing=0;
    
    _collectionView =[[UICollectionView alloc]initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, SCREEN_HEIGHT-120) collectionViewLayout:flowLayout];
    _collectionView.pagingEnabled=YES;
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    _collectionView.backgroundColor=[UIColor whiteColor];
    
    UINib * nib=[UINib nibWithNibName:@"MyCollectionViewCell" bundle:nil];
    [_collectionView registerNib:nib forCellWithReuseIdentifier:MYCOLLECTIONVIEW_CELL_ID];
    [self.view addSubview:_collectionView];
}

-(void)addTopView
{
    UINib * nib=[UINib nibWithNibName:@"TopView" bundle:nil];
    NSArray * nibArray=[nib instantiateWithOwner:nil options:nil];
    self.topView=[nibArray lastObject];
    self.topView.frame=CGRectMake(0, 20, SCREEN_WIDTH, 40);
    [self.view addSubview:self.topView];
}

-(void)addBottomView
{
    UINib * nib=[UINib nibWithNibName:@"BottomView" bundle:nil];
    NSArray * nibArray=[nib instantiateWithOwner:nil options:nil];
    self.bottomView=[nibArray lastObject];;
    __weak typeof(self)weakself=self;
    [self.bottomView setButtonBlock:^(NSInteger tag){
        [weakself openView:tag];
    }];
    self.bottomView.frame=CGRectMake(0,SCREEN_HEIGHT-60, SCREEN_WIDTH, 60);
    [self.view addSubview:self.bottomView];
}

-(void)openView:(NSInteger)tag
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;
    if (tag==300) {
        NSInteger index=self.collectionView.contentOffset.x/self.view.frame.size.width;
        DataModel * model=[self.dataArray objectAtIndex:index];
        MapViewController * mapVC=[[MapViewController alloc]init];
        mapVC.model=model;
        
        [self.navigationController pushViewController:mapVC animated:YES];
    }else if(tag==301){
        ListViewController * listVC=[[ListViewController alloc]init];
        [listVC updatePicCollectionViewWithArray:self.dataArray];
        [listVC setPictureBlock:^(NSInteger index){
            self.collectionView.contentOffset=CGPointMake(self.view.frame.size.width*index, 0);
        }];
        [self.navigationController pushViewController:listVC animated:YES];
    }
}


-(void)loadDataFormNet
{
    [[DataEngine shareInstance]requestDataFromNet:1 success:^(id responseObject) {
        self.dataArray=[AnalyseNetData parseData:responseObject];
        [self.collectionView reloadData];
    } faild:^(NSError *error) {
        
    }];
}

#pragma mark----懒加载
-(NSMutableArray *)dataArray
{
    if (_dataArray==nil) {
        _dataArray=[[NSMutableArray alloc]init];
    }
    return _dataArray;
}

#pragma  mark------<UICollectionViewDataSource,UICollectionViewDelegate>

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //290+text高度
    MyCollectionViewCell * cell=[_collectionView dequeueReusableCellWithReuseIdentifier:MYCOLLECTIONVIEW_CELL_ID forIndexPath:indexPath];
    DataModel * model=[self.dataArray objectAtIndex:indexPath.row];
      [cell updateUIWithModel:model];
    return cell;
}

@end
