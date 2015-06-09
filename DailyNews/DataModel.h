//
//  DataModel.h
//  DailyNews
//
//  Created by qianfeng on 15/6/6.
//  Copyright (c) 2015年 chelongfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject

@property(nonatomic,copy)NSString * guid;
@property(nonatomic,copy)NSString * type;
@property(nonatomic,copy)NSString * cat;
@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * cover_thumb;
@property(nonatomic,copy)NSString * cover_landscape;
@property(nonatomic,copy)NSString * cover_landscape_hd;
@property(nonatomic,copy)NSString * pubdate;
@property(nonatomic,copy)NSString * archive_timestamp;
@property(nonatomic,copy)NSString * pubdate_timestamp;
@property(nonatomic,copy)NSString * lastupdate_timestamp;
@property(nonatomic,copy)NSString * author;
@property(nonatomic,copy)NSString * source;
@property(nonatomic,copy)NSString * link_share;
@property(nonatomic,copy)NSString * link_wechat;
@property(nonatomic,copy)NSString * title_wechat_tml;
@property(nonatomic,copy)NSString * has_caption;
@property(nonatomic,copy)NSString * has_news;
@property(nonatomic,copy)NSString * has_photo;
@property(nonatomic)float latitude;
@property(nonatomic)float longitude;
@property(nonatomic,copy)NSString * summary;
@property(nonatomic,copy)NSString * content;
@property(nonatomic,copy)NSString * coordinate_sets;
@property(nonatomic,copy)NSString * entry_imgs;
//决定页数
@property(nonatomic,copy)NSString * album_count;
@property(nonatomic,copy)NSString * news_count;
@property(nonatomic,copy)NSArray  * album;

-(void)setValue:(id)value forUndefinedKey:(NSString *)key;

-(id)valueForUndefinedKey:(NSString *)key;


@end
