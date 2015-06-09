//
//  PictureCollectionCell.h
//  DailyNews
//
//  Created by qianfeng on 15/6/7.
//  Copyright (c) 2015年 chelongfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModel.h"

@interface PictureCollectionCell : UICollectionViewCell

-(void)updateImageViewWithModel:(DataModel *)model;

@end
