
//
//  MyImageView.m
//  DailyNews
//
//  Created by qianfeng on 15/6/6.
//  Copyright (c) 2015年 chelongfei. All rights reserved.
//

#import "MyImageView.h"

@implementation MyImageView

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewClick:)];
        self.userInteractionEnabled=YES;
        [self addGestureRecognizer:tap];
    }
    return self;
}

-(void)imageViewClick:(UITapGestureRecognizer *)tap
{
    MyImageView * imageView=(MyImageView *)tap.view;
    DataModel * model=imageView.model;
    _imageClickBlock(model);
}


@end
