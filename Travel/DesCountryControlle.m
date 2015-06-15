//
//  DesCountryControlle.m
//  Travel
//
//  Created by qianfeng on 15/6/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DesCountryControlle.h"
#import "DataEngine.h"
#import "AnalyticalNetWorkData.h"
#import "SectionFootView.h"
#import "SectionHeadView.h"
#import "PriceOffView.h"
#import "LocalColoringView.h"
#import "DesCountryHeadView.h"
#import "HotCityCell.h"
#import "DesTripModel.h"
#import "DesDiscountModel.h"
#import "DetailViewController.h"
#import "DesCityController.h"
#import "URLDefine.h"

#define COLLECT_HEAD_VIEW_ID @"collectionHeadViewId"
#define COLLECT_SECTION_HEAD_ID @"collectionSectionHeadId"
#define COLLECT_SECTION_FOOT_ID @"collectionSectionFootId"
#define COLLECT_HOTCITY_CELL_ID @"collectionHotCityCellId"
#define COLLECT_PRICE_CELL_ID @"collectionPriceCellId"
#define COLLECT_LOCAL_CELL_ID @"collectionLocationCellId"

@interface DesCountryControlle ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
//数组中四个小数组,第一个(一个对象)是model,第二个是hotCountrty数组
//第三个是disCount数组,第四个是trip数组
@property(nonatomic)NSMutableArray * dataArray;

@property(nonatomic)UICollectionView * collectionView;

@end

@implementation DesCountryControlle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCollectionView];
    [self fetchDataWithUrl];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
    
}

-(void)addCollectionView
{
    UICollectionViewFlowLayout * flowLayout=[[UICollectionViewFlowLayout alloc]init];
    flowLayout.sectionInset=UIEdgeInsetsMake(0, 10, 0, 10);
    flowLayout.minimumInteritemSpacing=0;
    flowLayout.minimumLineSpacing=0;
    
    
    self.collectionView=[[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:flowLayout];
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;
    self.collectionView.backgroundColor=[UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    NSLog(@"%f,%f", self.view.frame.size.width,self.view.frame.size.height);
    [self registViewForCollectionView];
    [self.view addSubview:self.collectionView];
}

-(void)registViewForCollectionView
{
    
    UINib * headViewNib=[UINib nibWithNibName:@"DesCountryHeadView" bundle:nil];
    [self.collectionView registerNib:headViewNib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:COLLECT_HEAD_VIEW_ID];
    
    UINib * secHeadNib=[UINib nibWithNibName:@"SectionHeadView" bundle:nil];
    [self.collectionView registerNib:secHeadNib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:COLLECT_SECTION_HEAD_ID];
    
    UINib * secFootNib=[UINib nibWithNibName:@"SectionFootView" bundle:nil];
    [self.collectionView registerNib:secFootNib forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:COLLECT_SECTION_FOOT_ID];
    
    UINib * hotCityNib=[UINib nibWithNibName:@"HotCityCell" bundle:nil];
    [self.collectionView registerNib:hotCityNib forCellWithReuseIdentifier:COLLECT_HOTCITY_CELL_ID];
    
    UINib * priceNib=[UINib nibWithNibName:@"PriceOffView" bundle:nil];
    [self.collectionView registerNib:priceNib forCellWithReuseIdentifier:COLLECT_PRICE_CELL_ID];
    
    UINib * localNib=[UINib nibWithNibName:@"LocalColoringView" bundle:nil];
    [self.collectionView registerNib:localNib forCellWithReuseIdentifier:COLLECT_LOCAL_CELL_ID];
    
}

-(void)fetchDataWithUrl
{
    [[DataEngine shareInstance]requestDestinationDetailCountryDataWithCountryID:self.model.id success:^(NSData *respondsObject) {
        self.dataArray=[AnalyticalNetWorkData parseDestinationDetailCountryData:respondsObject];
        [self.collectionView reloadData];
        
    } faild:^(NSError *error) {
        
    }];
}

#pragma mark------<UICollectionViewDataSource,UICollectionViewDelegate>

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    //判断数组是否为空来判断数据,决定section个数
    NSInteger secNo=4;
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
            HotCityCell * cell=[self.collectionView dequeueReusableCellWithReuseIdentifier:COLLECT_HOTCITY_CELL_ID forIndexPath:indexPath];
            cell.layer.borderColor=[UIColor lightGrayColor].CGColor;
            cell.layer.borderWidth=0.5;
            DesHotCityModel * model=[detailArray objectAtIndex:indexPath.row];
            [cell updateCellUIWithModel:model];
            return cell;
            break;}
        case 2:{
            NSArray * detailArray=[self.dataArray objectAtIndex:indexPath.section];
            LocalColoringView * locationCell=[self.collectionView dequeueReusableCellWithReuseIdentifier:COLLECT_LOCAL_CELL_ID forIndexPath:indexPath];
            DesTripModel * model=[detailArray objectAtIndex:indexPath.row];
            [locationCell updateUIWithDesTripModel:model];
            locationCell.layer.borderColor=[UIColor lightGrayColor].CGColor;
            locationCell.layer.borderWidth=0.5;
            return locationCell;
            break;}
        case 3:{
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

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 1:{
            NSArray * detailArray=[self.dataArray objectAtIndex:indexPath.section];
            DesHotCityModel * model=[detailArray objectAtIndex:indexPath.row];
            DesCityController * desCityVC=[[DesCityController alloc]init];
            desCityVC.model=model;
            [self.navigationController pushViewController:desCityVC animated:YES];
            break;}
        case 2:{
            NSArray * detailArray=[self.dataArray objectAtIndex:indexPath.section];
            DesTripModel * model=[detailArray objectAtIndex:indexPath.row];
            DetailViewController * detailVC=[[DetailViewController alloc]init];
            detailVC.url=model.view_url;
            [self.navigationController pushViewController:detailVC animated:YES];
            break;}
        case 3:{
            NSArray * detailArray=[self.dataArray objectAtIndex:indexPath.section];
            DesDiscountModel * model=[detailArray objectAtIndex:indexPath.row];
            NSString * url=[NSString stringWithFormat:RECOMMEND_DISCOUNT_URL,model.id];
            DetailViewController * detailVC=[[DetailViewController alloc]init];
            detailVC.url=url;
            [self.navigationController pushViewController:detailVC animated:YES];
            break;}
        default:
            break;
    }
}

#pragma mark----<UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size;
    CGFloat width=(self.view.frame.size.width-20)/2.0;
    switch (indexPath.section) {
        case 1:
            size=CGSizeMake(width, 130);
            return size;
            break;
        case 2:
            size=CGSizeMake(width, 210);
            return size;
            break;
            
        case 3:
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
    CGFloat width=self.view.frame.size.width-20;
    CGSize  size=CGSizeMake(width,70);
    if (section==0) {
        size=CGSizeMake(self.collectionView.frame.size.width,450);
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
            DesCountryHeadView * headView=[self.collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier: COLLECT_HEAD_VIEW_ID forIndexPath:indexPath];
            
            DesCountryModel * model=[[self.dataArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
            
            [headView updateUIWithModel:model];
            return headView;
        }
    }else{
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            //返回Header视图
            SectionHeadView * headView=[self.collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier: COLLECT_SECTION_HEAD_ID forIndexPath:indexPath];
            NSArray * array=@[@"热门城市",@"玩当地特色",@"抢特价折扣"];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end