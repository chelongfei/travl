//
//  AnalyticalNetWorkData.m
//  Travel
//
//  Created by qianfeng on 15/6/5.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AnalyticalNetWorkData.h"

@implementation AnalyticalNetWorkData

+(NSMutableArray *)parseRecommendData:(id)responseObject
{
    NSMutableArray * recommendDataArray=[NSMutableArray array];
    NSDictionary * oraginDict=(NSDictionary *)responseObject;
    NSDictionary * dataDict=oraginDict[@"data"];
    NSArray * nameArray=@[@"slide",@"subject",@"discount",@"mguide"];
    for (int index=0;index<4;index++) {
        NSArray * array=dataDict[nameArray[index]];
        NSMutableArray * tempArray=[[ NSMutableArray alloc]init];
        for (NSDictionary * dict in array) {
            RecommendModel * model=[[RecommendModel alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            [tempArray addObject:model];
        }
        [recommendDataArray addObject:tempArray];
    }
    return recommendDataArray;
}


+(NSMutableArray *)parseDestinationData:(id)responseObject
{
    NSMutableArray * destinationDataArray=[NSMutableArray array];
    
    NSDictionary * oraginDict=(NSDictionary *)responseObject;
    
    NSArray * dataArray=oraginDict[@"data"];
    
    NSMutableArray * buttonArray=[[NSMutableArray alloc]init];
    NSMutableArray * hotCountryArray=[[NSMutableArray alloc]init];
    NSMutableArray * countryArray=[[NSMutableArray alloc]init];
    //解析第一层数据
    for (NSDictionary * firstDic in dataArray) {
        DestinationModel * continentModel=[[DestinationModel alloc]init];
        [continentModel setValuesForKeysWithDictionary:firstDic];
        [buttonArray addObject:continentModel];
        
        //解析热门目的地数据
        NSMutableArray * firstHotArray=[self analyticalDataForDestinationModelArray:continentModel.hot_country];
        [hotCountryArray addObject:firstHotArray];
        
        //解析其他目的地数据
        NSMutableArray * firstCountryArray=[self analyticalDataForDestinationModelArray:continentModel.country];
        [countryArray addObject:firstCountryArray];
        
    }
    
    [destinationDataArray addObject:buttonArray];
    [destinationDataArray addObject:hotCountryArray];
    [destinationDataArray addObject:countryArray];
    
    return destinationDataArray;
}

+(NSMutableArray *)analyticalDataForDestinationModelArray:(NSArray *)array
{
    NSMutableArray * dataArray=[NSMutableArray array];
    for (NSDictionary * hotCountryDict in array) {
        DestinationModel * model=[[DestinationModel alloc]init];
        [model setValuesForKeysWithDictionary:hotCountryDict];
        [dataArray addObject:model];
    }
    return dataArray;
}

+(NSMutableArray *)parseGroupData:(id)responseObject
{
    //总数组
    NSMutableArray * dataArray=[[NSMutableArray alloc]init];
    

    
    NSDictionary * orginDic=(NSDictionary *)responseObject;
    NSArray * orginArray=orginDic[@"data"];
    for (NSDictionary * dict in orginArray) {
        //二层数组
        NSMutableArray * secondDataArray=[[NSMutableArray alloc]init];
        NSMutableArray * titleModelArray=[[NSMutableArray alloc]init];
        NSMutableArray * cellModelArray=[[NSMutableArray alloc]init];
        GroupModel * model=[[GroupModel alloc]init];
        [model setValuesForKeysWithDictionary:dict];
        [titleModelArray addObject:model];
        
        for (NSDictionary * dic in model.group) {
            GroupModel * model=[[GroupModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [cellModelArray addObject:model];
        }
        [secondDataArray addObject:titleModelArray];
        [secondDataArray addObject:cellModelArray];
        [dataArray addObject:secondDataArray];
    }
    return dataArray;
}

@end
