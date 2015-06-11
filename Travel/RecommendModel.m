//
//  RecommendModel.m
//  Travel
//
//  Created by qianfeng on 15/6/3.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "RecommendModel.h"

@implementation RecommendModel
@synthesize description=_description;

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.url         forKey:@"MyUrl"];
    [aCoder encodeObject:self.photo       forKey:@"MyPhoto"];
    [aCoder encodeObject:self.title       forKey:@"MyTitle"];
    [aCoder encodeObject:self.id          forKey:@"MyID"];
    [aCoder encodeObject:self.user_id     forKey:@"MyUserId"];
    [aCoder encodeObject:self.username    forKey:@"MyUserName"];
    [aCoder encodeObject:self.avatar      forKey:@"MyAvatar"];
    [aCoder encodeObject:self.description forKey:@"MyDesc"];
    [aCoder encodeObject:self.count       forKey:@"MyCount"];
    [aCoder encodeObject:self.price       forKey:@"MyPrice"];
    [aCoder encodeObject:self.end_date    forKey:@"MyEndDate"];
    [aCoder encodeObject:self.priceoff    forKey:@"MyPriceOff"];
    
    
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super init]) {
    self.url=[aDecoder decodeObjectForKey:@"MyUrl"];
    self.photo =[aDecoder decodeObjectForKey:@"MyPhoto"];
    self.title =[aDecoder decodeObjectForKey:@"MyTitle"];
    self.id    =[aDecoder decodeObjectForKey:@"MyID"];
    self.user_id  =[aDecoder decodeObjectForKey:@"MyUserId"];
    self.username =[aDecoder decodeObjectForKey:@"MyUserName"];
    self.avatar   =[aDecoder decodeObjectForKey:@"MyAvatar"];
    self.description =[aDecoder decodeObjectForKey:@"MyDesc"];
    self.count   =[aDecoder decodeObjectForKey:@"MyCount"];
    self.price   =[aDecoder decodeObjectForKey:@"MyPrice"];
    self.end_date =[aDecoder decodeObjectForKey:@"MyEndDate"];
    self.priceoff =[aDecoder decodeObjectForKey:@"MyPriceOff"];
    }
    return self;
}

@end
