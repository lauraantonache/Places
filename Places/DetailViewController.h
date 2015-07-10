//
//  DetailViewController.h
//  Places
//
//  Created by qualitance on 10/07/15.
//  Copyright (c) 2015 lauraa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@interface DetailViewController : UIViewController
@property (strong, nonatomic) GMSPlace* place;
@end
