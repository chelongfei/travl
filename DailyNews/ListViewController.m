//
//  ListViewController.m
//  DailyNews
//
//  Created by qianfeng on 15/6/7.
//  Copyright (c) 2015年 chelongfei. All rights reserved.
//

#import "ListViewController.h"
#import "PictureCollectionCell.h"

#define PICCOLLECTIONCELLID @"picCollectionCellId"

@interface ListViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic)UICollectionView * collectionView;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addCollectionView];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
    
    [self.navigationItem setTitle:@"新闻列表"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addCollectionView
{
        UICollectionViewFlowLayout * flowLayout=[[UICollectionViewFlowLayout alloc]init];
        CGFloat itemWidth=(self.view.frame.size.width-35)/4.0;
        CGFloat itemHeight=self.view.frame.size.width/7.0;
        flowLayout.itemSize=CGSizeMake(itemWidth,itemHeight);
        flowLayout.sectionInset=UIEdgeInsetsMake(5, 10, 5, 10);
        flowLayout.minimumInteritemSpacing=5;
        flowLayout.minimumLineSpacing=5;
        
        self.collectionView=[[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:flowLayout];
        self.collectionView.delegate=self;
        self.collectionView.backgroundColor=[UIColor whiteColor];
        self.collectionView.dataSource=self;
        [self.collectionView registerClass:[PictureCollectionCell class] forCellWithReuseIdentifier:PICCOLLECTIONCELLID];
        [self.view addSubview:self.collectionView];
}


-(void)updatePicCollectionViewWithArray:(NSMutableArray *)dataArray
{
    self.dataArray=dataArray;
    [self.collectionView reloadData];
}

#pragma mark-----<UICollectionViewDataSource,UICollectionViewDelegate>

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PictureCollectionCell * cell=[self.collectionView dequeueReusableCellWithReuseIdentifier:PICCOLLECTIONCELLID forIndexPath:indexPath];
    DataModel * model=[self.dataArray objectAtIndex:indexPath.row];
    [cell updateImageViewWithModel:model];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.pictureBlock(indexPath.row);
    [self.navigationController popViewControllerAnimated:YES];
}


@end
