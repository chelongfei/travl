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
#import "CityMapModel.h"
#import "MyAnnotationView.h"
#import "MyAnnotation.h"
#import <objc/message.h>
#import <objc/runtime.h>

#define ANNOTATION_ID  @"annotationId"


@interface MapViewController ()<MKMapViewDelegate>

@property(nonatomic)MKMapView * mapView;

@property(nonatomic)MKAnnotationView * currentView;

@property(nonatomic)NSMutableArray * dataArray;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addMapView];
    [self addBottomViewWithImageName:@""];
    [self fetchDataWithUrl];
    
}

-(void)addBottomViewWithImageName:(NSString *)imageName
{
    
}

-(void)addMapView
{
    self.mapView=[[MKMapView alloc]initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height-70)];
    self.mapView.delegate=self;
    CLLocationCoordinate2D coordinate=CLLocationCoordinate2DMake(22.290245,114.165092);
    MKCoordinateSpan span=MKCoordinateSpanMake(0.3, 0.3);
    MKCoordinateRegion region=MKCoordinateRegionMake(coordinate, span);
    [self.mapView setRegion:region animated:YES];
    [self.view addSubview:self.mapView];
}

-(void)fetchDataWithUrl
{
    [[DataEngine shareInstance]requestCityCricleButtonMapWithcityID:self.cityID CategoryId:self.categoryID success:^(NSData *respondsObject) {
        self.dataArray=[AnalyticalNetWorkData parseCircleButtonMapData:respondsObject];
        [self addAnnotation];
    } faile:^(NSError *error) {
        
    }];
}

-(void)addAnnotation
{
    int index=0;
    for (CityMapModel * model in self.dataArray) {
        MKPointAnnotation * annotation=[[MKPointAnnotation alloc]init];
        annotation.coordinate=CLLocationCoordinate2DMake([model.lat floatValue], [model.lng floatValue]);
       annotation.title=model.cnname;
        objc_setAssociatedObject(annotation, "model", model, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        objc_setAssociatedObject(annotation, "index", [NSNumber numberWithInt:index], OBJC_ASSOCIATION_ASSIGN);
        [self.mapView addAnnotation:annotation];
        index++;
    }
}

#pragma mark----懒加载

-(NSMutableArray *)dataArray
{
    if (_dataArray==nil) {
        _dataArray=[[NSMutableArray alloc]init];
    }
    return _dataArray;
}

#pragma mark----<MKMapViewDelegate>

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKAnnotationView   *myAnnotationView = (MKAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:ANNOTATION_ID];
    if (myAnnotationView == nil) {
        myAnnotationView = [[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:ANNOTATION_ID];
    }
    myAnnotationView.canShowCallout = YES;
    int index=[objc_getAssociatedObject(annotation, "index") intValue];
    if (index<10) {
        myAnnotationView.image=[UIImage imageNamed:@"ic_map_scenic_recommend"];
        myAnnotationView.frame=CGRectMake(0, 0, 21, 28);
        
    }else{
        myAnnotationView.image=[UIImage imageNamed:@"ic_map_poi_scenic"];
        myAnnotationView.frame=CGRectMake(0, 0, 10, 10);
    }
    return myAnnotationView;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    MKPointAnnotation * annotation=(MKPointAnnotation *)view.annotation;
    int index=[objc_getAssociatedObject(annotation, "index") intValue];
    CityMapModel * model=objc_getAssociatedObject(annotation, "model");
    if (index<10) {
        if (self.currentView==nil) {
            self.currentView=view;
            view.image=[UIImage imageNamed:@"ic_map_scenic_recommend_pressed.png"];
            view.frame=CGRectMake(0, 0, 21, 28);
        }else if(self.currentView!=view){
            self.currentView.selected=NO;
            self.currentView.image=[UIImage imageNamed:@"ic_map_scenic_recommend.png"];
            self.currentView.frame=CGRectMake(0, 0, 21, 28);
            self.currentView=view;
            self.currentView.selected=YES;
            view.image=[UIImage imageNamed:@"ic_map_scenic_recommend_pressed.png"];
            view.frame=CGRectMake(0, 0, 21, 28);
        }
        
    }else{
        if (self.currentView==nil) {
            self.currentView=view;
            view.image=[UIImage imageNamed:@"ic_map_poi_scenic_pressed.png"];
            view.frame=CGRectMake(0, 0, 10, 10);
        }else if(self.currentView!=view){
            self.currentView.selected=NO;
            self.currentView.image=[UIImage imageNamed:@"ic_map_poi_scenic.png"];
            self.currentView.frame=CGRectMake(0, 0, 10, 10);
            self.currentView=view;
            self.currentView.selected=YES;
            view.image=[UIImage imageNamed:@"ic_map_poi_scenic_pressed.png"];
            view.frame=CGRectMake(0, 0, 10, 10);
        }
        
    }
    [self changeRegionOfMap:model];
    [self callDetailViewAboutAnnotation:model];
}

-(void)changeRegionOfMap:(CityMapModel *)model
{
    MKCoordinateRegion region=self.mapView.region;
    region.center=CLLocationCoordinate2DMake([model.lat floatValue], [model.lng floatValue]);
    [self.mapView setRegion:region animated:YES];
}

-(void)callDetailViewAboutAnnotation:(CityMapModel *)model
{
    
    
}


@end
