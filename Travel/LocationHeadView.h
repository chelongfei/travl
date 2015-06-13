//
//  LocationHeadView.h
//  Travel
//
//  Created by qianfeng on 15/6/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendModel.h"

@interface LocationHeadView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;

-(void)updateHeadViewWithModel:(RecommendModel *)model;

-(CGFloat)getHeadHeightWithModel:(RecommendModel *)model width:(CGFloat)width;

@end
