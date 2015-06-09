//
//  ListViewController.h
//  DailyNews
//
//  Created by qianfeng on 15/6/7.
//  Copyright (c) 2015年 chelongfei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^PictureChooseBlock)(NSInteger index);
@interface ListViewController : UIViewController

@property(nonatomic)NSMutableArray * dataArray;
@property(nonatomic,copy)PictureChooseBlock pictureBlock;

-(void)updatePicCollectionViewWithArray:(NSMutableArray *)dataArray;

@end
