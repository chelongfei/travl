//
//  DataEngine.m
//  DailyNews
//
//  Created by qianfeng on 15/6/6.
//  Copyright (c) 2015年 chelongfei. All rights reserved.
//

#import "DataEngine.h"
#import "AFNetworking.h"

#define URL  @"http://idaily-cdn.idai.ly/api/list/v3/iphone/zh-hans?page=1&ver=iphone&app_ver=18"

@implementation DataEngine

{
    AFHTTPRequestOperationManager * _manager;
}

-(id)init
{
    if (self=[super init]) {
        _manager=[AFHTTPRequestOperationManager manager];
    }
    return self;
}

+(instancetype)shareInstance
{
    static DataEngine * s_dataEngine=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_dataEngine=[[DataEngine alloc]init];
    });
    return s_dataEngine;
}

-(void)requestDataFromNet:(NSInteger)pageNo success:(RequestDataBlockSuccess)success faild:(RequestDataBlockFaild) faild
{
    
    
    [_manager POST:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
           success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (faild) {
          faild(error);
        }
    }];
}



@end
