//
//  RecommedView.h
//  Travel
//
//  Created by qianfeng on 15/6/3.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecommendView : UIView

@property(nonatomic)UITableView * tableView;

-(void)updateHeadView:(NSMutableArray *)dataArray;

@end
