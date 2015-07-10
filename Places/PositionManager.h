//
//  PositionManager.h
//  Places
//
//  Created by qualitance on 10/07/15.
//  Copyright (c) 2015 lauraa. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;

@protocol PositionProtocol;

@interface PositionManager : NSObject <CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong,atomic) id<PositionProtocol> delegate;
+(id) sharedManager;
-(void) requestPosition;
@end

@protocol PositionProtocol
-(void) getCurrentLocation: (CLLocation*)currentLocation ;
@end
