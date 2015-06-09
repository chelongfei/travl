//
//  MyImageView.h
//  DailyNews
//
//  Created by qianfeng on 15/6/6.
//  Copyright (c) 2015年 chelongfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModel.h"

typedef void (^ImageClickBlockHandler)(DataModel *model);

@interface MyImageView : UIImageView

@property(nonatomic)DataModel * model;
@property(nonatomic,copy)ImageClickBlockHandler imageClickBlock;

@end
