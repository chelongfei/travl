//
//  SettingViewController.m
//  DailyNews
//
//  Created by qianfeng on 15/6/7.
//  Copyright (c) 2015年 chelongfei. All rights reserved.
//

#import "SettingViewController.h"
#import "SDImageCache.h"

@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate, UIActionSheetDelegate>

@property(nonatomic)UITableView * tableView;
@property(nonatomic)NSMutableArray * dataArray;


@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.dataArray = [NSMutableArray arrayWithObjects:@[@"清除缓存"], @[@"版本 V1.0.0",@"感谢使用天天短新闻应用"], nil];
    
    [self addTableView];
    
}

-(void)addTableView
{
    self.tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
}

#pragma mark-----<UITableViewDataSource,UITableViewDelegate>

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataArray count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray[section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = self.dataArray[indexPath.section][indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    if (indexPath.section==0) {
        [self section0Action:row];
    }
}

- (void)section0Action:(NSInteger)row {

            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:[NSString stringWithFormat:@"确定清除缓存%.2fM", [self getCacheSize]] delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [sheet showInView:self.view];
}


#pragma mark - <UIActionSheetDelegate>
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) { // 确定清除
        [self removeCacheData];
    } else {
    }
}

- (void)removeCacheData {
    [[SDImageCache sharedImageCache] clearDisk];
}

// 得到缓存文件有多少兆
- (double)getCacheSize {
    
    SDImageCache *imageCache = [SDImageCache sharedImageCache];
    NSUInteger fileSize = [imageCache getSize]; // 以字节为单位
    NSLog(@"SD Cache: %lfM", fileSize/1024.0/1024.0);
    
    // 假设我们做了缓存，缓存地址为沙盒的Library/Caches/MyCaches 注意，缓存路径随意，这里只是假设
    NSString *myCachePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/MyCaches"];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    // 获取指定文件信息
    NSDictionary *fileInfo = [fm attributesOfItemAtPath:myCachePath error:nil];
    NSLog(@"本地缓存字节：%llu", fileInfo.fileSize);
    
    // SD图片缓存加上我们自己的缓存
    fileSize += fileInfo.fileSize;
    
    // 以兆为单位返回
    return fileSize/1024.0/1024.0;
}


@end
