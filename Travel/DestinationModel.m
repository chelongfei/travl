//
//  DestinationModel.m
//  Travel
//
//  Created by qianfeng on 15/6/5.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DestinationModel.h"

@implementation DestinationModel

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.id         forKey:@"MyID"];
    [aCoder encodeObject:self.cnname      forKey:@"MyCnname"];
    [aCoder encodeObject:self.enname       forKey:@"MyEnname"];
    [aCoder encodeObject:self.hot_country          forKey:@"MyHotCountry"];
    [aCoder encodeObject:self.country     forKey:@"MyCountry"];
    [aCoder encodeObject:self.photo   forKey:@"MyPhoto"];
    [aCoder encodeObject:self.count      forKey:@"MyCount"];
    [aCoder encodeObject:self.label forKey:@"MyLabel"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super init]) {
        self.id=[aDecoder decodeObjectForKey:@"MyID"];
        self.cnname =[aDecoder decodeObjectForKey:@"MyCnname"];
        self.enname =[aDecoder decodeObjectForKey:@"MyEnname"];
        self.hot_country    =[aDecoder decodeObjectForKey:@"MyHotCountry"];
        self.country  =[aDecoder decodeObjectForKey:@"MyCountry"];
        self.photo =[aDecoder decodeObjectForKey:@"MyPhoto"];
        self.count   =[aDecoder decodeObjectForKey:@"MyCount"];
        self.label =[aDecoder decodeObjectForKey:@"MyLabel"];
    }
    return self;
}


@end
