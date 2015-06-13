//
//  DesDiscountModel.h
//  Travel
//
//  Created by qianfeng on 15/6/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "BaseModel.h"

@interface DesDiscountModel : BaseModel

@property(nonatomic,copy)NSString * id;
@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * price;
@property(nonatomic,copy)NSString * priceoff;
@property(nonatomic,copy)NSString * expire_date;
@property(nonatomic,copy)NSString * photo;

@end
