//
//  MapWithoutURLController.m
//  Travel
//
//  Created by qianfeng on 15/6/18.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MapWithoutURLController.h"
#import <MapKit/MapKit.h>
#import "LocationModel.h"
#import <objc/message.h>


#define ANNOTATION_ID  @"annotationId"
#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height

@interface MapWithoutURLController ()<MKMapViewDelegate>

@property(nonatomic)MKMapView * mapView;

@property(nonatomic)MKAnnotationView * currentView;

@end

@implementation MapWithoutURLController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCustomNavgationBar];
    [self addMapView];
    [self setCoordinateForMap];
    [self addAnnotation];
    
}

-(void)addCustomNavgationBar
{
    self.view.backgroundColor=[UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    self.navigationController.navigationBarHidden=YES;
    
    self.bar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20,WIDTH, 50)];
    
    self.bar.barTintColor=[UIColor colorWithRed:35/255.0 green:169/255.0 blue:118/255.0 alpha:1.0];
    
    UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:nil];
    
    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [left setFrame:CGRectMake(0, 10, 30, 30)];
    
    [left setImage:[UIImage imageNamed:@"ic_back_white.png"] forState:(UIControlStateNormal)];
    
    [left addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:left];
    
    [item setLeftBarButtonItem:leftButton];
    
    [self.bar pushNavigationItem:item animated:NO];
    
    [self.view addSubview:self.bar];
}

-(void)addMapView
{
    self.mapView=[[MKMapView alloc]initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height-70)];
    self.mapView.delegate=self;
    [self.view addSubview:self.mapView];
}

-(void)setCoordinateForMap
{
    LocationModel * model=[self.dataArray objectAtIndex:0];
    CLLocationCoordinate2D coordinate=CLLocationCoordinate2DMake([model.lat floatValue], [model.lng floatValue]);
    MKCoordinateSpan span=MKCoordinateSpanMake(0.2, 0.2);
    MKCoordinateRegion region=MKCoordinateRegionMake(coordinate, span);
    [self.mapView setRegion:region animated:YES];
}

-(void)addAnnotation
{
    int index=0;
    for (LocationModel * model in self.dataArray) {
        MKPointAnnotation * annotation=[[MKPointAnnotation alloc]init];
        annotation.coordinate=CLLocationCoordinate2DMake([model.lat floatValue], [model.lng floatValue]);
        annotation.title=model.chinesename;
        objc_setAssociatedObject(annotation, "model", model, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        objc_setAssociatedObject(annotation, "index", [NSNumber numberWithInt:index], OBJC_ASSOCIATION_ASSIGN);
        [self.mapView addAnnotation:annotation];
        index++;
    }
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark-----

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
    myAnnotationView.image=[UIImage imageNamed:@"ic_map_scenic_recommend"];
    myAnnotationView.frame=CGRectMake(0, 0, 21, 28);
    return myAnnotationView;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    MKPointAnnotation * annotation=(MKPointAnnotation *)view.annotation;
    LocationModel * model=objc_getAssociatedObject(annotation, "model");
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
    [self changeRegionOfMap:model];
}

-(void)changeRegionOfMap:(LocationModel *)model
{
    MKCoordinateRegion region=self.mapView.region;
    region.center=CLLocationCoordinate2DMake([model.lat floatValue], [model.lng floatValue]);
    [self.mapView setRegion:region animated:YES];
}

@end
