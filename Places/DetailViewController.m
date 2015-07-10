//
//  DetailViewController.m
//  Places
//
//  Created by qualitance on 10/07/15.
//  Copyright (c) 2015 lauraa. All rights reserved.
//

#import "DetailViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface DetailViewController ()
@property (strong, atomic ) GMSPlacesClient* placesClient;
@property (strong, atomic) IBOutlet UILabel* nameLabel;
@property (strong, atomic) IBOutlet UILabel* addressLabel;
@property (strong,atomic) IBOutlet UILabel* phoneLabel;
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
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setPlace:(GMSPlace *)place
{
    _place = place;
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
