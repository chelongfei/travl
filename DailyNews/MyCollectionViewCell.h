//
//  MyCollectionViewCell.h
//  DailyNews
//
//  Created by qianfeng on 15/6/6.
//  Copyright (c) 2015年 chelongfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModel.h"
#import "MyImageView.h"

@interface MyCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *landscapeImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property(nonatomic)MyImageView * firstBottomImage;
@property(nonatomic)MyImageView * secondBottomImage;
@property(nonatomic)MyImageView * thirdBottomImage;
@property(nonatomic)NSMutableArray * modelArray;

-(void)updateUIWithModel:(DataModel *)model;

@end
