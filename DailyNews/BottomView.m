//
//  BottomView.m
//  DailyNews
//
//  Created by qianfeng on 15/6/7.
//  Copyright (c) 2015年 chelongfei. All rights reserved.
//

#import "BottomView.h"
#import "CoreDataManager.h"

@interface BottomView()



@end



@implementation BottomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)MapButton:(UIButton *)sender {
    if (self.buttonBlock) {
        self.buttonBlock(sender.tag);
    }
}

- (IBAction)enshrineButton:(UIButton *)sender {
//    [CoreDataManager addModelToCoreData:];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"IWantCollect" object:nil];
}


@end
