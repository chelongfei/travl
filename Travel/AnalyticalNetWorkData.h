//
//  AnalyticalNetWorkData.h
//  Travel
//
//  Created by qianfeng on 15/6/5.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface AnalyticalNetWorkData : NSObject

//解析推荐页面的信息并返回
+(NSMutableArray *)parseRecommendData:(id)responseObject;

//解析目的地页面的信息并返回
+(NSMutableArray *)parseDestinationData:(id)responseObject;

//解析社区页面信息并返回
+(NSMutableArray *)parseGroupData:(id)responseObject;

//解析推荐页面的cell信息并返回
+(NSMutableArray *)parseRecommendCell:(id)responseObject;

//解析社区二级页面全部栏目的cell信息并返回
+(NSMutableArray *)parseGroupDetailData:(id)responseObject;

//解析推荐页面当地特色栏目信息并返回
+(NSMutableArray *)parseRecommendLocation:(id)responseObject;

//解析目的地界面具体国家信息并返回
+(NSMutableArray *)parseDestinationDetailCountryData:(id)responseObject;



@end
