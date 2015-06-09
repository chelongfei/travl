//
//  DataEngine.h
//  DailyNews
//
//  Created by qianfeng on 15/6/6.
//  Copyright (c) 2015年 chelongfei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^RequestDataBlockSuccess)(id responseObject);
typedef void (^RequestDataBlockFaild)(NSError * error);

@interface DataEngine : NSObject

+(instancetype)shareInstance;

-(void)requestDataFromNet:(NSInteger)pageNo success:(RequestDataBlockSuccess)success faild:(RequestDataBlockFaild) faild;

@end
