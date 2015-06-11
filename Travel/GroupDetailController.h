//
//  GroupDetailController.h
//  Travel
//
//  Created by qianfeng on 15/6/11.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupModel.h"
#import "GroupDetailModel.h"



@interface GroupDetailController : UIViewController

@property(nonatomic)NSString * id;

@property(nonatomic)GroupModel * model;

-(void)updateHeadViewWithModel:(GroupModel *)model;



@end
