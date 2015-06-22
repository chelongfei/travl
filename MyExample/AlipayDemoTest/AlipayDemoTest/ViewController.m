//
//  ViewController.m
//  AlipayDemoTest
//
//  Created by qianfeng on 15/5/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ViewController.h"
#import "MyPayHeader.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton * button=[UIButton buttonWithType:(UIButtonTypeSystem)];
    [button setTitle:@"支付" forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(pay) forControlEvents:(UIControlEventTouchUpInside)];
    button.frame=CGRectMake(100, 100, 100, 100);
    [self.view addSubview:button];
}
-(void)pay
{
    Order *order = [[Order alloc] init];
    order.partner = PartnerID;
    order.seller = SellerID;
    order.tradeNO = @"2343"; //订单ID(由商家□自□行制定
    order.productName =@"手机"; //商品标题
    order.productDescription = @"降价"; //商品描述
    order.amount = @"0.01"; //商 品价格
    order.notifyURL = @"http://www.baidu.com"; //回调URL
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"alisdkdemo";
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description]; NSLog(@"orderSpec = %@",orderSpec);
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循 RSA 签名规范, 并将签名字符串 base64 编码和 UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(PartnerPrivKey);
    NSString *signedString = [signer signString:orderSpec];
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
    }
}
@end
