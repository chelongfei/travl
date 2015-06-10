//
//  RecommendHeadView.m
//  Travel
//
//  Created by qianfeng on 15/6/3.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "RecommendHeadView.h"
#import "RecommendModel.h"
#import "UIImageView+WebCache.h"
#import "MyImageView.h"
#import "PriceOffView.h"
#import "LocalColoringView.h"

@interface RecommendHeadView()<UIScrollViewDelegate>
{
    NSTimer * _timer;
    NSInteger _scrollViewPageNumber;
    NSInteger _currentPage;
}


@property(nonatomic)PriceOffView * priceOffView;
@property(nonatomic)LocalColoringView * localView;

@end

@implementation RecommendHeadView


//刷新headView上的UI
-(void)updateRecommendHeadView:(NSMutableArray *)dataArray
{
    [self updateScrollView:dataArray[0]];
    [self updateSubjectView:dataArray[1]];
    [self updateDiscountView:dataArray[2]];
    [self updateLocalColoringView:dataArray[3]];
}

//更新头视图上的scrollView
-(void)updateScrollView:(NSArray *)array
{
    _scrollViewPageNumber=array.count+2;
    self.pageController.numberOfPages=_scrollViewPageNumber-2;
    _scrollView.contentSize=CGSizeMake(_scrollView.frame.size.width*(array.count+2), 0);
    for (int index=0; index<=array.count+1; index++) {
        if (index==0||index==array.count+1) {
            RecommendModel * model=(index==0?array[array.count-1]:array[0]);
            CGRect frame=CGRectMake(index*_scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
            MyImageView * imageView=[[ MyImageView alloc]initWithFrame:frame model:model];
            [imageView sd_setImageWithURL:[NSURL URLWithString:model.photo]];
            [_scrollView addSubview:imageView];
        }else{
            RecommendModel * model=array[index-1];
            CGRect frame=CGRectMake(index*_scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
            MyImageView * imageView=[[ MyImageView alloc]initWithFrame:frame model:model];
            [imageView sd_setImageWithURL:[NSURL URLWithString:model.photo]];
            [_scrollView addSubview:imageView];
        }
        
    }
    [self insertSubview:self.pageController aboveSubview:self.scrollView];
    self.scrollView.contentOffset=CGPointMake(self.frame.size.width, 0);
    self.pageController.currentPage=0;
    _currentPage=2;
   //开启定时器让pageController更改
   _timer=[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(scrollViewPageChange) userInfo:nil repeats:YES];
}

//定时器启动
-(void)scrollViewPageChange
{
    if (_currentPage==_scrollViewPageNumber) {
            self.pageController.currentPage=0;
            self.scrollView.contentOffset=CGPointMake(self.frame.size.width, 0);
            _currentPage=2;
    }else if (_currentPage==1){
        self.pageController.currentPage=_scrollViewPageNumber-3;
        self.scrollView.contentOffset=CGPointMake(self.frame.size.width*(_scrollViewPageNumber-2), 0);
        _currentPage=_scrollViewPageNumber-1;
    }else{
        _currentPage++;
        self.pageController.currentPage++;
        if (_currentPage==_scrollViewPageNumber) {
            self.pageController.currentPage=0;
        }
        [UIView animateWithDuration:1 animations:^{
            self.scrollView.contentOffset=CGPointMake((_currentPage-1)*self.frame.size.width, 0);
        }];
    }
}

-(void)updateSubjectView:(NSArray *)array
{
    for (int index=0; index<array.count; index++) {
        RecommendModel * model=array[index];
        switch (index) {
            case 0:{
                CGRect frame=CGRectMake(8, 48, _SubjiectView.frame.size.width-16,141);
                [self addImageViewToSubjectViewWithModel:model frame:frame];
                break;}
            case 1:{
                CGRect frame=CGRectMake(8, 197, 165,117);
                [self addImageViewToSubjectViewWithModel:model frame:frame];
                break;}
            case 2:{
                CGRect frame=CGRectMake(186, 197, 165,117);
                [self addImageViewToSubjectViewWithModel:model frame:frame];
                break;}
            default:
                break;
        }
    }
}

-(void)addImageViewToSubjectViewWithModel:(RecommendModel *)model frame:(CGRect)frame
{
    MyImageView * imageView=[[MyImageView alloc]initWithFrame:frame model:model];
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.photo]];
    [self.SubjiectView addSubview:imageView];
}

-(void)updateDiscountView:(NSArray * )array
{
    for (int index=0; index<array.count; index++) {
        RecommendModel * model=array[index];
        UINib * nib=[UINib nibWithNibName:@"PriceOffView" bundle:nil];
        NSArray * nibArray=[nib instantiateWithOwner:nil options:nil];
        self.priceOffView=[nibArray lastObject];
        _priceOffView.frame=[self frameForPriceOffView:index];
        [_priceOffView updateUIWithModel:model];
        [self.discountView addSubview:_priceOffView];
    }
}

-(CGRect)frameForPriceOffView:(int)index
{
    CGFloat width=(_discountView.frame.size.width-20)/2.0;
    CGFloat height=(_discountView.frame.size.height-100)/2.0;
    CGFloat padding=5;
    CGRect frame;
    return frame=index%2==0?CGRectMake(padding, 50+(padding+height)*(index/2), width,height):CGRectMake(padding+padding+width+padding, 50+(padding+height)*(index/2), width,height);
}

-(void)updateLocalColoringView:(NSArray *)array
{
    for (int index=0; index<array.count; index++) {
        RecommendModel * model=array[index];
        UINib * nib=[UINib nibWithNibName:@"LocalColoringView" bundle:nil];
        NSArray * nibArray=[nib instantiateWithOwner:nil options:nil];
        self.localView=[nibArray lastObject];
        self.localView.frame=[self frameForLocalColoringView:index];
        [_localView updateUIWithModel:model];
        [self.localColoringView addSubview:_localView];
    }
}

-(CGRect)frameForLocalColoringView:(int)index
{
    CGFloat width=(_localColoringView.frame.size.width-20)/2.0;
    CGFloat height=(_localColoringView.frame.size.height-80)/2.0;
    CGFloat padding=5;
    CGRect frame;
    return frame=index%2==0?CGRectMake(padding, 60+(padding+height)*(index/2), width,height):CGRectMake(padding+padding+width+padding, 60+(padding+height)*(index/2), width,height);
}

#pragma mark------<UIScrollViewDelegate>

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger currentPage=self.scrollView.contentOffset.x/self.frame.size.width;
    _currentPage=currentPage+1;
    if (_currentPage==1) {
        self.pageController.currentPage=_scrollViewPageNumber-3;
         self.scrollView.contentOffset=CGPointMake(self.frame.size.width*(_scrollViewPageNumber-2), 0);
    }else if (_currentPage==_scrollViewPageNumber){
        self.pageController.currentPage=0;
       self.scrollView.contentOffset=CGPointMake(self.frame.size.width, 0);
    }else{
        if (_currentPage==_scrollViewPageNumber) {
            self.pageController.currentPage=0;
        }else{
            self.pageController.currentPage=currentPage-1;
        }
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_timer invalidate];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
   _timer=[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(scrollViewPageChange) userInfo:nil repeats:YES];
}



@end
