//
//  ScanQRViewController.m
//  QRDemo
//
//  Created by qianfeng on 15-5-28.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

//ios7才开始支持

#import "ScanQRViewController.h"
#import <AVFoundation/AVFoundation.h>


@interface ScanQRViewController ()<AVCaptureMetadataOutputObjectsDelegate>

//使用AVCaptureDevice 代表一个捕获设备，摄像头
@property(nonatomic)AVCaptureDevice *device;

//AVCaptureDeviceInput 代表输入设备,使用AVCaptureDevice来初始化
@property(nonatomic)AVCaptureDeviceInput *deviceInput;

//AVCaptureMetadataOutput 代表某种类型的输出，譬如我们这里使用二维码，一旦摄像头捕获到二维码，就会输出
@property(nonatomic)AVCaptureMetadataOutput *output;

//会话，把输入，输出结合在一起
@property(nonatomic)AVCaptureSession *session;

//预览的layer，把捕获的视频在该layer上显示出来
@property(nonatomic)AVCaptureVideoPreviewLayer *previewLayer;

@end

@implementation ScanQRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //捕获视频，defaultDeviceWithMediaType 默认使用的是后置摄像头
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    //使用指定的设备作为输入
    self.deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    
    //指定输出Metadata，可以给他指定某种类型，譬如二维码，当视频捕获到到二维码的时候产生输出
    self.output = [[AVCaptureMetadataOutput alloc]init];
    //当扫描到指定的类型时，在主队列上调用代理方法
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //[self.output setMetadataObjectTypes:<#(NSArray *)#>];
    
    //生成session，把input和output结合起来
    self.session = [[AVCaptureSession alloc]init];
    
    //canAddInput判断指定的设备是否能否加入到session
    if ([self.session canAddInput:self.deviceInput]) {
        [self.session addInput:self.deviceInput];
    }
    
    if ([self.session canAddOutput:self.output]) {
        [self.session addOutput:self.output];
    }
    
    //必须把output添加到session之后才能指定类型
    //指定元数据类型为QR编码
    [self.output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    
    
    //生成预览层,并添加到self.view.layer上
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:self.session];
    self.previewLayer.frame = CGRectMake(10, 100, 300, 300);
    //设置视频到填充模式，拉伸填充
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:self.previewLayer];
    
    //开始启动设备进行捕获
    [self.session startRunning];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if([metadataObjects count] > 0){
       AVMetadataMachineReadableCodeObject *object = [metadataObjects lastObject];
        
        //object.stringValue 就是解码二维码的结果
        NSLog(@"-----%@",object.stringValue);
        
        //停止扫描
        [self.session stopRunning];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
