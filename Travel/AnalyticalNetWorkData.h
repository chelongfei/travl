//
//  AnalyticalNetWorkData.h
//  Travel
//
//  Created by qianfeng on 15/6/5.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecommendModel.h"
#import "DestinationModel.h"
#import "GroupModel.h"
#import "RecommendCellModel.h"


@interface AnalyticalNetWorkData : NSObject

//解析推荐页面的信息并返回
+(NSMutableArray *)parseRecommendData:(id)responseObject;

//解析目的地页面的信息并返回
+(NSMutableArray *)parseDestinationData:(id)responseObject;

//解析社区页面信息并返回
+(NSMutableArray *)parseGroupData:(id)responseObject;

//解析推荐页面的cell信息并返回
+(NSMutableArray *)parseRecommendCell:(id)responseObject;

@end
