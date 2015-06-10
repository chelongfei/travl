//
//  ViewController.m
//  Travel
//
//  Created by qianfeng on 15/6/3.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ViewController.h"
#import "SVProgressHUD.h"
#import "URLDefine.h"
#import "DataEngine.h"
#import "RecommendModel.h"
#import "RecommendView.h"
#import "DetailViewController.h"
#import "DestinationView.h"
#import "AnalyticalNetWorkData.h"
#import "GroupView.h"


#define COLLECTIONVIEW_CELLID @"collectionViewCellId"
#define SCREEN_WIDTH  self.view.frame.size.width
#define SCREEN_HEIGHT self.view.frame.size.height
#define WHITESLIDERPADDING  60


@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate,UICollectionViewDelegateFlowLayout>
@property(nonatomic)UIButton * currentButton;
@property (nonatomic)UICollectionView *HomeCollectionView;
@property (weak, nonatomic) IBOutlet UIView *whiteSliderForHeadButton;

//推荐界面view的数据存储
//数组中包含了四个数组,分别对应
//[@"slide",@"subject",@"discount",@"mguide"];
@property(nonatomic)NSMutableArray * recommendDataArray;

////第二个界面view的数据存储,需要三个数组,对应button数组,hot_country数组,country数组
//hot_countr里面包含7个数组,对应7大洲,每个数组里面7个对象
//country里面7个数组对应7大洲,每个数组里面7个对象
@property(nonatomic)NSMutableArray * destinationDataArray;

//第三个view的数据存储
@property(nonatomic)NSMutableArray * groupDataArray;

//推荐页面的view
@property(nonatomic)RecommendView * recommendView;

//社区页面的view
@property(nonatomic)GroupView * groupView;

@end

@implementation ViewController

//注册collectionView的cell
-(void)awakeFromNib
{
    
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self addHomeCollectionView];
    [self loadRecommendData];
    [self loadDestinationData];
    [self loadGroupData];
}

-(void)initView
{
    //隐藏navigationBar
    self.navigationController.navigationBarHidden=YES;
    //设置当前selected的按钮
    _currentButton=(UIButton *)[self.view viewWithTag:10000];
    _currentButton.selected=YES;
}

-(void)addHomeCollectionView
{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize=CGSizeMake(self.view.frame.size.width, self.view.frame.size.height-80);
    flowLayout.minimumInteritemSpacing=0;
    flowLayout.minimumLineSpacing=0;
    flowLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    
    _HomeCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, self.view.frame.size.height-80) collectionViewLayout:flowLayout];
    _HomeCollectionView.pagingEnabled=YES;
    _HomeCollectionView.showsHorizontalScrollIndicator=NO;
    _HomeCollectionView.delegate=self;
    _HomeCollectionView.dataSource=self;
    //注册cell
    [self.HomeCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:COLLECTIONVIEW_CELLID];
    [self.view addSubview:_HomeCollectionView];
}

//使用通知中心观察图片点击事件
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
    
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reciveImageClick:) name:@"imageClick" object:nil];
}

//接收到图片点击事件后的处理事件
-(void)reciveImageClick:(NSNotification *)notify
{
    RecommendModel * model=(RecommendModel *)notify.object;
    DetailViewController * detailVC=[[DetailViewController alloc]init];
    detailVC.url=model.url;
    [self.navigationController pushViewController:detailVC animated:YES];
}

//加载推荐页面的数据
-(void)loadRecommendData
{
    [[DataEngine shareInstance]requestRecommendData:^(NSData *respondsObject) {
        self.recommendDataArray=[AnalyticalNetWorkData parseRecommendData:respondsObject];
        [self addRecommendView:self.recommendDataArray];
    } faild:^(NSError *error) {
        
    }];
}

//添加recommendView
-(void)addRecommendView:(NSMutableArray *)dataArray
{
    RecommendView * recommendView=[[RecommendView alloc]initWithFrame:(CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))];
    [recommendView updateHeadView:dataArray];
    [_HomeCollectionView addSubview:recommendView];
}

//加载目的地页面的数据
-(void)loadDestinationData
{
  [[DataEngine shareInstance]requestDestinationData:^(NSData *respondsObject) {
      self.destinationDataArray=[AnalyticalNetWorkData parseDestinationData:respondsObject];
      [self addDestinationView:self.destinationDataArray];
  } faild:^(NSError *error) {
      
  }];
}

//添加DestinationView
-(void)addDestinationView:(NSMutableArray *)dataArray
{
    DestinationView * destinationView=[[DestinationView alloc]initWithFrame:(CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height-80))];
    destinationView.dataArray=dataArray;
    [_HomeCollectionView addSubview:destinationView];
}

//加载社区页面的数据
-(void)loadGroupData
{
    [[DataEngine shareInstance]requestGroupData:^(NSData *respondsObject) {
        self.groupDataArray=[AnalyticalNetWorkData parseGroupData:respondsObject];
        [self addGroupView:self.groupDataArray];
    } faild:^(NSError *error) {
        
    }];
}

//添加GroupView
-(void)addGroupView:(NSMutableArray *)dataArray
{
    self.groupView=[[GroupView alloc]initWithFrame:(CGRectMake(self.view.frame.size.width*2, 0, self.view.frame.size.width, self.view.frame.size.height-80))];
    self.groupView.dataArray=dataArray;
    [_HomeCollectionView addSubview:self.groupView];
}

#pragma mark---懒加载区域

-(NSMutableArray *)recommendDataArray
{
    if (_recommendDataArray==nil) {
        _recommendDataArray=[NSMutableArray array];
    }
    return _recommendDataArray;
}

-(NSMutableArray *)destinationDataArray
{
    if (_destinationDataArray==nil) {
        _destinationDataArray=[[NSMutableArray alloc]init];
    }
    return _destinationDataArray;
}

-(NSMutableArray *)groupDataArray
{
    if (_groupDataArray==nil) {
        _groupDataArray=[[NSMutableArray alloc]init];
    }
    return _groupDataArray;
}

#pragma mark  XIB控件
//设置点击事件

- (IBAction)recommendButton:(UIButton *)button {
    if(_currentButton!=button){
        _currentButton.selected=NO;
        _currentButton=button;
        button.selected=!button.selected;
        _HomeCollectionView.contentOffset=CGPointMake(self.view.frame.size.width*(button.tag-10000), 0);
        [UIView animateWithDuration:0.5 animations:^{
            CGRect frame=_currentButton.frame;
            frame.origin.y=_whiteSliderForHeadButton.frame.origin.y;
            self.whiteSliderForHeadButton.frame=frame;
        }];
    }
}

#pragma mark-------<UICollectionViewDataSource,UICollectionViewDelegate>
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[self.HomeCollectionView dequeueReusableCellWithReuseIdentifier:COLLECTIONVIEW_CELLID forIndexPath:indexPath];
    switch (indexPath.row) {
        case 1:
            cell.backgroundColor=[UIColor greenColor];
            break;
        case 2:
            cell.backgroundColor=[UIColor orangeColor];
            break;
        default:
            break;
    }
    return cell;
}

#pragma mark  UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger currentPage=_HomeCollectionView.contentOffset.x/self.view.frame.size.width;
    
    UIButton * button=(UIButton *)[self.view viewWithTag:currentPage+10000];
    if(_currentButton!=button){
        _currentButton.selected=NO;
        _currentButton=button;
        button.selected=!button.selected;
        [UIView animateWithDuration:0.5 animations:^{
            CGRect frame=_currentButton.frame;
            frame.origin.y=_whiteSliderForHeadButton.frame.origin.y;
            self.whiteSliderForHeadButton.frame=frame;
        }];
        
    }
}

#pragma mark----dealloc
-(void)dealloc
{
   [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
