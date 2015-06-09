//
//  AnalyseNetData.h
//  DailyNews
//
//  Created by qianfeng on 15/6/6.
//  Copyright (c) 2015年 chelongfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnalyseNetData : NSObject

+(NSMutableArray *)parseData:(id)responder;

+(NSMutableArray *)parsePageData:(NSArray *)array;

@end
