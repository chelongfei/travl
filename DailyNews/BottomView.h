//
//  BottomView.h
//  DailyNews
//
//  Created by qianfeng on 15/6/7.
//  Copyright (c) 2015年 chelongfei. All rights reserved.
//

#import <UIKit/UIKit.h>

 typedef void (^BottomButtonBlock)(NSInteger index);

@interface BottomView : UIView

@property(nonatomic,copy)BottomButtonBlock buttonBlock;

@end
