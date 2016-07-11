//
//  ViewController.m
//  SimulatorLocation
//
//  Created by JamesGu on 16/7/11.
//  Copyright © 2016年 JamesGu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<CLLocationManagerDelegate>
{
    CLLocationManager *_locationManager;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [_locationManager requestWhenInUseAuthorization];
    }
    [_locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    if (
        ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)] && status != kCLAuthorizationStatusNotDetermined && status !=kCLAuthorizationStatusAuthorizedWhenInUse) ||
        (![_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)] && status != kCLAuthorizationStatusNotDetermined && status !=kCLAuthorizationStatusAuthorized)
        ) {
        
        NSString *message = @"您的手机目前未开启定位服务，如欲开启定位服务，请至设定开启定位服务功能";
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"无法定位" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        
    }else {
        
        [_locationManager startUpdatingLocation];
    }
}
@end
