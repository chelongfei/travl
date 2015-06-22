//
//  HttpDownloader.m
//  HttpResumDownloadDemo
//
//  Created by qianfeng on 15-5-22.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HttpDownloader.h"
#import "NSString+Hashing.h"

@implementation HttpDownloader
{
    NSURLConnection *_connection;
    unsigned long long _downloadFileSize; //记录已经下载的字节数
    unsigned long long _totalFileSize;   //总的字节数
    
    //对文件进行读写操作的类，文件句柄
    NSFileHandle *_fileHandle;
}

+(instancetype)sharedInstance
{
    static HttpDownloader *g_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_instance = [[HttpDownloader alloc]init];
    });
    return g_instance;
}


//开始下载的接口
-(void)start:(NSString*)url
{
    //对URL进行MD5编码，编码后作为文件名
    NSString *fileName = [url MD5Hash];
    [self makeSureFileExist:fileName];
    
    //读取目前已经下载的字节数
    _downloadFileSize = [self readDownloadFileSize:[self getFileFullPath:fileName]];
    
    //打开文件句柄，为写做准备
    _fileHandle = [NSFileHandle fileHandleForWritingAtPath:[self getFileFullPath:fileName]];
    
    //NSMutableURLRequest 如果需要修改http的头字段，使用NSMutableURLRequest
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:url]];
    NSString *byteField = [NSString stringWithFormat:@"bytes=%lld-",_downloadFileSize];
    // [request addValue:@"bytes=500-" forHTTPHeaderField:@"Range"];
    [request addValue:byteField forHTTPHeaderField:@"Range"];
    _connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
}

-(unsigned long long)readDownloadFileSize:(NSString*)fileFullPath
{
    //attributesOfItemAtPath 获取文件的属性，包括大小，创建日期，修改日期
    NSDictionary *dic = [[NSFileManager defaultManager] attributesOfItemAtPath:fileFullPath error:nil];
    return [dic fileSize];
}

-(void)makeSureFileExist:(NSString*)fileName
{
    //得到文件的全路径
    NSString *fileFullPath = [self getFileFullPath:fileName];
    BOOL bFileExist = [[NSFileManager defaultManager] fileExistsAtPath:fileFullPath];
    if (!bFileExist) {
        //如果文件不存在创建之
        [[NSFileManager defaultManager] createFileAtPath:fileFullPath contents:nil attributes:nil];
    }
}

-(NSString*)getFileFullPath:(NSString*)fileName
{
    NSString *homeDir =  NSHomeDirectory();
    NSString *fileFullPath = [NSString stringWithFormat:@"%@/Documents/%@",homeDir,fileName];
    //NSLog(@"%@",fileFullPath);
    return fileFullPath;
}

//停止下载的接口
-(void)stop
{
    //停止下载
    [_connection cancel];
    
    //关掉文件句柄，释放资源
    [_fileHandle closeFile];
    
    _connection = nil;
    _fileHandle = nil;
}

#pragma mark -
#pragma mark NSURLConnectionDataDelegate
//收到了响应
//response.expectedContentLength 返回期望的内容长度
//假设文件总长度是500
//Range=bytes=100-，expectedContentLength为400，返回的是剩余的文件的大小
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //文件的总长度 = 已经下载的 + 返回剩余的
    _totalFileSize = _downloadFileSize + response.expectedContentLength;
}

//接受到数据，开始把数据保存到文件
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //写前定位到文件的尾部，防止数据覆盖
    [_fileHandle seekToEndOfFile];
    //写数据
    [_fileHandle writeData:data];
    
    //更新已经下载的大小
    _downloadFileSize += data.length;
    
    //更新进度，使用代理传值
    if ([self.delegate respondsToSelector:@selector(httpDownloader:dowloadSize:totalSize:)]) {
        [self.delegate httpDownloader:self dowloadSize:_downloadFileSize totalSize:_totalFileSize];
    }
}

//下载完成，结束
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if ([self.delegate respondsToSelector:@selector(httpDownloader:dowloadComplete:)]) {
        [self.delegate httpDownloader:self dowloadComplete:YES];
    }
}

//失败了
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    [self stop];
}
@end
