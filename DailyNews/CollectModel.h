//
//  CollectModel.h
//  DailyNews
//
//  Created by qianfeng on 15/6/9.
//  Copyright (c) 2015年 chelongfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface CollectModel : NSManagedObject

@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * content;
@property(nonatomic,copy)NSString * cover_thumb;
@property(nonatomic,copy)NSString * cover_landscape;

@end
