//
//  DesCityController.m
//  Travel
//
//  Created by qianfeng on 15/6/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DesCityController.h"
#import "DataEngine.h"
#import "AnalyticalNetWorkData.h"
#import "CityHeadView.h"
#import "LocalColoringView.h"
#import "PriceOffView.h"
#import "CityModel.h"
#import "HotMguideModel.h"
#import "NewDiscountModel.h"
#import "SectionFootView.h"
#import "SectionHeadView.h"
#import "DetailViewController.h"
#import "LocationViewController.h"
#import "URLDefine.h"
#import "CircleButtonController.h"



#define COLLECTION_HEAD_VIEW_ID @"collectionHeadViewId"

#define COLLECT_SECTION_HEAD_ID @"collectionSectionHeadId"
#define COLLECT_SECTION_FOOT_ID @"collectionSectionFootId"
#define COLLECT_PRICE_CELL_ID @"collectionPriceCellId"
#define COLLECT_LOCAL_CELL_ID @"collectionLocationCellId"


@interface DesCityController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

//数组中三个小数组,第一个(一个对象)是model,第二个是hotMguideModel数组
//第三个是new_disCount数组
@property(nonatomic)NSMutableArray * dataArray;
@property(nonatomic)UICollectionView * collectionView;

@end

@implementation DesCityController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCollectionView];
    [self fetchDataWithUrl];
    
}

-(void)addCollectionView
{
    UICollectionViewFlowLayout * flowLayout=[[UICollectionViewFlowLayout alloc]init];
    flowLayout.sectionInset=UIEdgeInsetsMake(0, 10, 0, 10);
    flowLayout.minimumInteritemSpacing=0;
    flowLayout.minimumLineSpacing=0;
    
    self.collectionView=[[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;
    self.collectionView.backgroundColor=[UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    
        [self registViewForCollectionView];
    [self.view addSubview:self.collectionView];
}

-(void)registViewForCollectionView
{
    //高度860;
    UINib * headViewNib=[UINib nibWithNibName:@"CityHeadView" bundle:nil];
    [self.collectionView registerNib:headViewNib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:COLLECTION_HEAD_VIEW_ID];
    
    UINib * secHeadNib=[UINib nibWithNibName:@"SectionHeadView" bundle:nil];
    [self.collectionView registerNib:secHeadNib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:COLLECT_SECTION_HEAD_ID];
    
    UINib * secFootNib=[UINib nibWithNibName:@"SectionFootView" bundle:nil];
    [self.collectionView registerNib:secFootNib forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:COLLECT_SECTION_FOOT_ID];
    
    UINib * priceNib=[UINib nibWithNibName:@"PriceOffView" bundle:nil];
    [self.collectionView registerNib:priceNib forCellWithReuseIdentifier:COLLECT_PRICE_CELL_ID];
    
    UINib * localNib=[UINib nibWithNibName:@"LocalColoringView" bundle:nil];
    [self.collectionView registerNib:localNib forCellWithReuseIdentifier:COLLECT_LOCAL_CELL_ID];
    
}

-(void)fetchDataWithUrl
{
    [[DataEngine shareInstance]requestDestinationDetailCityDataWithCityID:self.model.id success:^(NSData *respondsObject) {
        self.dataArray=[AnalyticalNetWorkData parseDestinationDetailCityData:respondsObject];
        [self.collectionView reloadData];
    } faild:^(NSError *error) {
        
    }];
}

#pragma mark --<UICollectionViewDataSource,UICollectionViewDelegate>

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    //判断数组是否为空来判断数据,决定section个数
    NSInteger secNo=3;
    for (NSArray * arr in self.dataArray) {
        if (arr.count==0) {
            secNo--;
        }
    }
    return secNo;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section!=0) {
        NSArray * detailArray=[self.dataArray objectAtIndex:section];
        return [detailArray count];
    }else{
        return 0;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 1:{
            NSArray * detailArray=[self.dataArray objectAtIndex:indexPath.section];
            LocalColoringView * locationCell=[self.collectionView dequeueReusableCellWithReuseIdentifier:COLLECT_LOCAL_CELL_ID forIndexPath:indexPath];
            DesTripModel * model=[detailArray objectAtIndex:indexPath.row];
            [locationCell updateUIWithDesTripModel:model];
            locationCell.layer.borderColor=[UIColor lightGrayColor].CGColor;
            locationCell.layer.borderWidth=0.5;
            return locationCell;
            break;}
        case 2:{
            NSArray * detailArray=[self.dataArray objectAtIndex:indexPath.section];
            PriceOffView * priceCell=[self.collectionView dequeueReusableCellWithReuseIdentifier:COLLECT_PRICE_CELL_ID forIndexPath:indexPath];
            DesDiscountModel * model=[detailArray objectAtIndex:indexPath.row];
            [priceCell updateUIWithDesDiscountModel:model];
            priceCell.layer.borderColor=[UIColor lightGrayColor].CGColor;
            priceCell.layer.borderWidth=0.5;
            return priceCell;
            break;}
        default:
            break;
    }
    return nil;
    
}

#pragma mark----<UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size;
    CGFloat width=(self.collectionView.frame.size.width-20)/2.0;
    switch (indexPath.section) {
        case 1:
            size=CGSizeMake(width, 210);
            return size;
            break;
        case 2:
            size=CGSizeMake(width, 230);
            return size;
            break;
        default:
            return CGSizeZero;
            break;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGFloat width=self.collectionView.frame.size.width-20;
    CGSize  size=CGSizeMake(width,70);
    if (section==0) {
        size=CGSizeMake(self.collectionView.frame.size.width,860);
    }
    return size;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section!=0) {
        CGFloat width=self.collectionView.frame.size.width-20;
        CGSize size=CGSizeMake(width,50);
        return size;
    }
    return CGSizeZero;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            CityHeadView * headView=[self.collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier: COLLECTION_HEAD_VIEW_ID forIndexPath:indexPath];
            
            __weak typeof(self)weakself=self;
            [headView setCircleBlock:^(NSString * categoryID){
                CircleButtonController * VC=[[CircleButtonController alloc]init];
                VC.categoryID=categoryID;
                VC.cityID=self.model.id;
                [weakself.navigationController pushViewController:VC animated:YES];
            }];
            CityModel * model=[[self.dataArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
            [headView updateUIWithModel:model];
            return headView;
        }
    }else{
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            //返回Header视图
            SectionHeadView * headView=[self.collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier: COLLECT_SECTION_HEAD_ID forIndexPath:indexPath];
            NSArray * array=@[@"玩当地特色",@"抢特价折扣"];
            headView.headTitle.text=[array objectAtIndex:indexPath.section-1];
            return headView;
        }else if([kind isEqualToString:UICollectionElementKindSectionFooter]){
            //返回Footer视图
            SectionFootView * footView=[self.collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:COLLECT_SECTION_FOOT_ID forIndexPath:indexPath];
            return footView;
        }
    }
    return nil;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 1:{
            NSArray * detailArray=[self.dataArray objectAtIndex:indexPath.section];
            HotMguideModel * model=[detailArray objectAtIndex:indexPath.row];
            LocationViewController * locationVC=[[LocationViewController alloc]init];
            locationVC.id=model.id;
            [self.navigationController pushViewController:locationVC animated:YES];
            break;}
        case 2:{
            NSArray * detailArray=[self.dataArray objectAtIndex:indexPath.section];
            NewDiscountModel * model=[detailArray objectAtIndex:indexPath.row];
            NSString * url=[NSString stringWithFormat:DISCOUNT_URL,model.id];
            DetailViewController * detailVC=[[DetailViewController alloc]init];
            detailVC.url=url;
            [self.navigationController pushViewController:detailVC animated:YES];
            break;}
        default:
            break;
    }
}

@end
