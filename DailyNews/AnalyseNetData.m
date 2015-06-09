//
//  AnalyseNetData.m
//  DailyNews
//
//  Created by qianfeng on 15/6/6.
//  Copyright (c) 2015年 chelongfei. All rights reserved.
//

#import "AnalyseNetData.h"
#import "DataModel.h"


@implementation AnalyseNetData

+(NSMutableArray *)parseData:(id)responder
{
    NSMutableArray * dataArray=[NSMutableArray array];
    NSArray * array=(NSArray *)responder;
    for (NSDictionary * dict in array) {
        DataModel * model=[[DataModel alloc]init];
        [model setValuesForKeysWithDictionary:dict];
        if (model.latitude!=0.000000) {
            [dataArray addObject:model];
        }
    }
    return dataArray;
}

+(NSMutableArray *)parsePageData:(NSArray *)array
{
    NSMutableArray * dataArray=[[NSMutableArray alloc]init];
    for (NSDictionary * dict in array) {
        DataModel * model=[[DataModel alloc]init];
        [model setValuesForKeysWithDictionary:dict];
        [dataArray addObject:model];
    }
    return dataArray;
}
@end
