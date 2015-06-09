//
//  PictureCollectionCell.m
//  DailyNews
//
//  Created by qianfeng on 15/6/7.
//  Copyright (c) 2015年 chelongfei. All rights reserved.
//

#import "PictureCollectionCell.h"
#import "UIImageView+WebCache.h"

@interface PictureCollectionCell ()
@property(nonatomic)UIImageView * imageView;

@end

@implementation PictureCollectionCell

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview: self.imageView];
    }
    return self;
}

-(void)updateImageViewWithModel:(DataModel *)model
{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.cover_thumb]];
}

@end
