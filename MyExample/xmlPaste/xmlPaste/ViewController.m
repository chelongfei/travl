//
//  ViewController.m
//  xmlPaste
//
//  Created by qianfeng on 15/6/10.
//  Copyright (c) 2015年 chelongfei. All rights reserved.
//

#import "ViewController.h"
#import "GDataXMLNode.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self pasteXML];
    
    
}


-(void)pasteXML
{
    NSString * xmlPath=[[NSBundle mainBundle]pathForResource:@"xml" ofType:@"txt"];
    NSData * data=[NSData dataWithContentsOfFile:xmlPath];
    GDataXMLDocument * document=[[GDataXMLDocument alloc]initWithData:data options:0 error:nil];
    NSArray * elementArray=[document.rootElement nodesForXPath:@"//book" error:nil];
    for (GDataXMLElement * element in elementArray) {

//           GDataXMLNode *node = [self attributeForName:key];
   NSString * language   = [[element attributeForName:@"language"] stringValue];
        //         GDataXMLElement *element = [self nodesForXPath:xpath error:nil][0];
   NSString * name       = [[element nodesForXPath:@"name" error:nil][0] stringValue];
   NSString * price      = [[element nodesForXPath:@"price" error:nil][0] stringValue];
   NSString * summary    = [[element nodesForXPath:@"summary" error:nil][0] stringValue];
   NSString * authorName = [[element nodesForXPath:@"author/name" error:nil][0] stringValue];
 NSLog(@"language:%@,name:%@,price:%@,summary:%@,authorName:%@",language,name,price,summary,authorName);
    }
   
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
