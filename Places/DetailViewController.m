//
//  DetailViewController.m
//  Places
//
//  Created by qualitance on 10/07/15.
//  Copyright (c) 2015 lauraa. All rights reserved.
//

#import "DetailViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import <MapKit/MapKit.h>


#define METERS_PER_MILE 1609.344
@interface DetailViewController ()
@property (strong, atomic ) GMSPlacesClient* placesClient;
@property (strong, atomic) IBOutlet UILabel* nameLabel;
@property (strong, atomic) IBOutlet UILabel* addressLabel;
@property (strong,atomic) IBOutlet UILabel* phoneLabel;
@property (strong,atomic) IBOutlet MKMapView* mapView;
@property (strong,atomic) IBOutlet UIButton* satelliteButton;
@property (strong,atomic) IBOutlet UIButton* standardButton;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

   // NSString *placeID = [self.place placeID];
    
        if (_place != nil) {
            NSLog(@"Place name %@", _place.name);
            NSLog(@"Place address %@", _place.formattedAddress);
            NSLog(@"Place placeID %@", _place.placeID);
            NSLog(@"Place attributions %@", _place.attributions);
        } else {
            NSLog(@"No place details for place");
        }
    self.title=_place.name;
    _nameLabel.text = _place.name;
    _addressLabel.text = _place.formattedAddress;
    _phoneLabel.text = _place.phoneNumber;
    [_mapView setScrollEnabled:YES];
    [_mapView setRegion: MKCoordinateRegionMakeWithDistance( _place.coordinate, 1*METERS_PER_MILE, 1*METERS_PER_MILE)];
    MKPointAnnotation* pointAnnotation = [[MKPointAnnotation alloc] init];
    [pointAnnotation setTitle:_place.name];
    [pointAnnotation setCoordinate:_place.coordinate];
    [_mapView addAnnotation:pointAnnotation];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setPlace:(GMSPlace *)place
{
    _place = place;
}

-(IBAction)buttonPressed:(UIButton*)sender{
    if([sender isEqual:_satelliteButton])
    {
        _mapView.mapType = MKMapTypeSatellite;
    }
    else if([sender isEqual:_standardButton])
    {
        _mapView.mapType = MKMapTypeStandard;
    }
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
