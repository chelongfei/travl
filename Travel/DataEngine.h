//
//  DataEngine.h
//  Travel
//
//  Created by qianfeng on 15/6/3.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SuccessBlockType) (NSData * respondsObject);
typedef void(^FailedBlockType)(NSError * error);

@interface DataEngine : NSObject
+(instancetype)shareInstance;
//获取推荐页面数据
-(void)requestRecommendData:(SuccessBlockType)success faild:(FailedBlockType)failed;

//获取目的地页面数据
-(void)requestDestinationData:(SuccessBlockType)success faild:(FailedBlockType)failed;

//获取社区页面数据
-(void)requestGroupData:(SuccessBlockType)success faild:(FailedBlockType)failed;

//获取推荐页面刷新CELL数据
-(void)requestRecommendCellDataWithPage:(NSInteger)pageNo success:(SuccessBlockType)success faild:(FailedBlockType)failed;

//获取社区二级页面数据

-(void)requestGroupDetailDataWithID:(NSString *)forId page:(NSInteger)pageNo type:(NSString *)type success:(SuccessBlockType)success faild:(FailedBlockType)failed;

@end
