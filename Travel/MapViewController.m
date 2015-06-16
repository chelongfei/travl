//
//  MapViewController.m
//  Travel
//
//  Created by qianfeng on 15/6/16.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>


@interface MapViewController ()

@property(nonatomic)MKMapView * mapView;


@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addMapView];
    
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
