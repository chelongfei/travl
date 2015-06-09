//
//  LocalColoringView.m
//  Travel
//
//  Created by qianfeng on 15/6/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LocalColoringView.h"
#import "UIImageView+WebCache.h"
@implementation LocalColoringView

-(void)updateUIWithModel:(RecommendModel *)model
{
    self.headOfWriterImageView.layer.borderColor=[UIColor whiteColor].CGColor;
    [self.MainImageView sd_setImageWithURL:[NSURL URLWithString:model.photo]];
    [self.headOfWriterImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    self.writerLabel.text=model.username;
    self.titleLabel.text=model.title;
}


@end
