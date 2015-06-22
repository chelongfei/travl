//
//  HttpDownloader.h
//  HttpResumDownloadDemo
//
//  Created by qianfeng on 15-5-22.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

//提前声明
@class HttpDownloader;

@protocol HttpDownloadProgressDelegate <NSObject>

-(void)httpDownloader:(HttpDownloader*)download dowloadSize:(unsigned long long)downloadSize totalSize:(unsigned long long)totalSize;

-(void)httpDownloader:(HttpDownloader *)download dowloadComplete:(BOOL)flag;

@end

@interface HttpDownloader : NSObject<NSURLConnectionDataDelegate>

+(instancetype)sharedInstance;

//代理对象，实现进度更新
@property(nonatomic,weak)id<HttpDownloadProgressDelegate> delegate;

//开始下载的接口
-(void)start:(NSString*)url;

//停止下载的接口
-(void)stop;

@end
