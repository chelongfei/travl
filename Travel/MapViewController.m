//
//  MapViewController.m
//  Travel
//
//  Created by qianfeng on 15/6/16.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "DataEngine.h"
#import "AnalyticalNetWorkData.h"


@interface MapViewController ()

@property(nonatomic)MKMapView * mapView;

@property(nonatomic)NSMutableArray * dataArray;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addMapView];
    [self fetchDataWithUrl];
    
}

-(void)addMapView
{
    self.mapView=[[MKMapView alloc]initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height-70)];
    CLLocationCoordinate2D coordinate=CLLocationCoordinate2DMake(22.290245,114.165092);
    MKCoordinateSpan span=MKCoordinateSpanMake(0.3, 0.3);
    MKCoordinateRegion region=MKCoordinateRegionMake(coordinate, span);
    [self.mapView setRegion:region animated:YES];
    [self.view addSubview:self.mapView];
}

-(void)fetchDataWithUrl
{
    NSLog(@"%@----%@",self.cityID,self.categoryID);
    [[DataEngine shareInstance]requestCityCricleButtonMapWithcityID:self.cityID CategoryId:self.categoryID success:^(NSData *respondsObject) {
        self.dataArray=[AnalyticalNetWorkData parseCircleButtonMapData:respondsObject];
        
    } faile:^(NSError *error) {
        
    }];
}

#pragma mark----懒加载

-(NSMutableArray *)dataArray
{
    if (_dataArray==nil) {
        _dataArray=[[NSMutableArray alloc]init];
    }
    return _dataArray;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
