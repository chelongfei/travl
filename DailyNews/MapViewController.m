//
//  MapViewController.m
//  DailyNews
//
//  Created by qianfeng on 15/6/7.
//  Copyright (c) 2015年 chelongfei. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapViewController ()

@property(nonatomic)MKMapView *mapView;
@property(nonatomic)MKPointAnnotation *annotion;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addMapView];
    [self updateLocationWithModel:self.model];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
    
    [self.navigationItem setTitle:@"新闻地点"];
}

-(void)addMapView
{
    self.mapView = [[MKMapView alloc]initWithFrame:self.view.frame];
    //构建一个坐标，使用经纬度
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(0,0);
    //方式2：按照中心点加距离的方式指定一个区域
    MKCoordinateRegion region2 = MKCoordinateRegionMakeWithDistance(coordinate, 100000, 100000);
    //让地图按照自己的经纬度比例来调整设置的区域
    region2 = [self.mapView regionThatFits:region2];
    //通知指定一个region，让地图显示
    [self.mapView setRegion:region2 animated:YES];
    self.mapView.layer.cornerRadius=5;
    self.mapView.layer.borderColor=[UIColor grayColor].CGColor;
    self.mapView.layer.borderWidth=2;
    [self.view addSubview:self.mapView];
}

-(void)updateLocationWithModel:(DataModel *)model
{
    NSLog(@"%f,%f",model.latitude,model.longitude);
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(model.latitude,model.longitude);
        MKCoordinateRegion region=MKCoordinateRegionMakeWithDistance(coordinate, 50000, 50000);
        [self.mapView removeAnnotation:_annotion];
        _annotion = [[MKPointAnnotation alloc] init];
        _annotion.coordinate = coordinate;
        _annotion.title = @"新闻地点";
        [self.mapView addAnnotation:_annotion];
        [self.mapView setRegion:region animated:YES];
}
//
//-(BOOL)reloadMapMessage
//{
//    NSInteger index=_collectionView.contentOffset.x/SCREEN_WIDTH;
//    DataModel * model=[self.dataArray objectAtIndex:index];
//    //           NSLog(@"%f",model.latitude);
//    if (model.latitude==0.000000) {
//        return NO;
//    }
//    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(model.latitude,model.longitude);
//    MKCoordinateRegion region=MKCoordinateRegionMakeWithDistance(coordinate, 50000, 50000);
//    
//    [self.mapView removeAnnotation:_annotion];
//    _annotion = [[MKPointAnnotation alloc] init];
//    _annotion.coordinate = coordinate;
//    _annotion.title = @"新闻地点";
//    [self.mapView addAnnotation:_annotion];
//    [self.mapView setRegion:region animated:YES];
//    return YES;
//}

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
