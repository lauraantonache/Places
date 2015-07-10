//
//  PositionManager.m
//  Places
//
//  Created by qualitance on 10/07/15.
//  Copyright (c) 2015 lauraa. All rights reserved.
//

#import "PositionManager.h"

@interface PositionManager()
@end
@implementation PositionManager



+ (id) sharedManager{
    static PositionManager *sharedPositionManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedPositionManager = [[self alloc] init];
    });
    return sharedPositionManager;
}




-(void) requestPosition{
    if(!_locationManager)
    {
        _locationManager = [CLLocationManager new];
        _locationManager.delegate = self;
        [_locationManager requestWhenInUseAuthorization];
    }
    
    [_locationManager startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [_locationManager stopUpdatingLocation];
    [self.delegate getCurrentLocation:[locations lastObject]];
}

@end