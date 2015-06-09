//
//  TopView.m
//  DailyNews
//
//  Created by qianfeng on 15/6/7.
//  Copyright (c) 2015年 chelongfei. All rights reserved.
//

#import "TopView.h"
#import "CoreDataManager.h"
#import "CollectModel.h"

@interface TopView()

@property(nonatomic)NSArray * array;

@end


@implementation TopView

- (IBAction)setting:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"setting" object:nil];
}

- (IBAction)MyCollect:(UIButton *)sender {
    self.array=[NSArray array];
    self.array=[[CoreDataManager defaultManager] fetchModelToUpdateUI];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"myCollect" object:_array];
}
@end
