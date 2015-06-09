//
//  MyImageView.m
//  Travel
//
//  Created by qianfeng on 15/6/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MyImageView.h"

@implementation MyImageView

-(id)initWithFrame:(CGRect)frame model:(RecommendModel *)model
{
    if (self=[super initWithFrame:frame]) {
        UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageClick:)];
        self.userInteractionEnabled=YES;
        [self addGestureRecognizer:tap];
        self.model=model;
    }
    return self;
}

-(void)imageClick:(UITapGestureRecognizer *)tap
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"imageClick" object:self.model];
}

@end
