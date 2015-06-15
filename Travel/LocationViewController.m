//
//  LocationViewController.m
//  Travel
//
//  Created by qianfeng on 15/6/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LocationViewController.h"
#import "LocationHeadView.h"
#import "LocationCollectCell.h"
#import "DataEngine.h"
#import "AnalyticalNetWorkData.h"

#define COLLECT_HEAD_VIEW_CELL @"collectionHeadViewCellID"
#define COLLECT_VIEW_CELL @"collectionViewCellID"

@interface LocationViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic)UICollectionView * collectionView;
@property(nonatomic)NSMutableArray * dataArray;

@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCollectionView];
    [self fetchDataWithUrl];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=NO;
}

-(void)addCollectionView
{
    UICollectionViewFlowLayout * flowLayout=[[UICollectionViewFlowLayout alloc]init];
    flowLayout.sectionInset=UIEdgeInsetsMake(10, 15, 10, 15);
    
    self.collectionView=[[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor=[UIColor whiteColor];
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    
    UINib * cellNib=[UINib nibWithNibName:@"LocationCollectCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:COLLECT_VIEW_CELL];
    
    UINib * nib=[UINib nibWithNibName:@"LocationHeadView" bundle:nil];
    [self.collectionView registerNib:nib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:COLLECT_HEAD_VIEW_CELL];
    
    [self.view addSubview:self.collectionView];
}

-(void)fetchDataWithUrl
{
    [[DataEngine shareInstance]requestRecommendLocationDataWithPage:self.model.id success:^(NSData *respondsObject) {
        self.dataArray=[AnalyticalNetWorkData parseRecommendLocation:respondsObject];
        [self.collectionView reloadData];
        
    } faild:^(NSError *error) {
        
    }];
}

#pragma mark----<UICollectionViewDataSource,UICollectionViewDelegate>

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LocationCollectCell * cell=[self.collectionView dequeueReusableCellWithReuseIdentifier:COLLECT_VIEW_CELL forIndexPath:indexPath];
    LocationModel * model=[self.dataArray objectAtIndex:indexPath.row];
    cell.layer.borderColor=[UIColor darkGrayColor].CGColor;
    cell.layer.borderWidth=0.3;
    [cell updateCollectionCellWithModel:model];
    return cell;
}


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    LocationHeadView * headView=[self.collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:COLLECT_HEAD_VIEW_CELL forIndexPath:indexPath];
    [headView updateHeadViewWithModel:self.model];
    
    return headView;
}

#pragma mark--<UICollectionViewDelegateFlowLayout>

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataArray>0) {
        LocationCollectCell * cell=[[LocationCollectCell alloc]init];
        LocationModel * model=[self.dataArray objectAtIndex:indexPath.row];
        CGFloat height=[cell getCellHeightWithModel:model width:self.view.frame.size.width-30];
        CGSize size=CGSizeMake(self.view.frame.size.width-30, height);
        return size;
    }else{
        return CGSizeZero;
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    LocationHeadView * headView=[[LocationHeadView alloc]init];
  CGFloat height= [headView getHeadHeightWithModel:self.model width:self.view.frame.size.width-55];
    CGSize size=CGSizeMake(self.view.frame.size.width, height);
    return size;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
