//
//  PriceOffView.m
//  Travel
//
//  Created by qianfeng on 15/6/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "PriceOffView.h"
#import "UIImageView+WebCache.h"
@implementation PriceOffView



-(void)updateUIWithRecommendModel:(RecommendModel *)model
{
    
    [_priceOffImageView sd_setImageWithURL:[NSURL URLWithString:model.photo]placeholderImage:[UIImage imageNamed:@"zbg_p9_cover_def_mid_round_corner.9.png"]];
    _titleLabel.text=model.title;
    _dateLabel.text=model.end_date;
    _priceLabel.attributedText=[self attributedStringOfPriceLabel:model.price];
    _priceOffLabel.attributedText=[self attributedStringOfPriceOffLabel:model.priceoff];
}

-(NSMutableAttributedString *)attributedStringOfPriceLabel:(NSString *)string
{
    NSScanner *scanner = [NSScanner scannerWithString:string];
    [scanner scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:nil];
    int number;
    [scanner scanInt:&number];
    NSString * str=[NSString stringWithFormat:@"%d元起",number];
    NSMutableAttributedString * price=[[NSMutableAttributedString alloc]initWithString:str];
    [price addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(str.length-2, 2)];
    return price;
}

-(NSMutableAttributedString *)attributedStringOfPriceOffLabel:(NSString *)string
{
    if (string.length>0) {
        NSMutableAttributedString * priceOff=[[NSMutableAttributedString alloc]initWithString:string];
        [priceOff addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, string.length-1)];
        return priceOff;
    }
    return nil;
}

-(void)updateUIWithDesDiscountModel:(DesDiscountModel *)model
{
    
    [_priceOffImageView sd_setImageWithURL:[NSURL URLWithString:model.photo]placeholderImage:[UIImage imageNamed:@"zbg_p9_cover_def_mid_round_corner.9.png"]];
    _titleLabel.text=model.title;
    _dateLabel.text=model.expire_date;
    _priceLabel.attributedText=[self attributedStringOfPriceLabel:model.price];
    _priceOffLabel.attributedText=[self attributedStringOfPriceOffLabel:model.priceoff];
}


@end
