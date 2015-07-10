//
//  PlacesTableViewController.m
//  Places
//
//  Created by qualitance on 09/07/15.
//  Copyright (c) 2015 lauraa. All rights reserved.
//

#import "PlacesTableViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "DetailViewController.h"
#import "PlacesTableViewCell.h"
@interface PlacesTableViewController ()
@property (strong, atomic ) GMSPlacesClient* placesClient;
@property (strong, atomic) GMSPlace* place;
@end

@implementation PlacesTableViewController

NSArray * placesResults;
//NSInteger placesIndex;

- (void)viewDidLoad {
    [super viewDidLoad];
    _placesClient = [[GMSPlacesClient alloc] init];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //[self placeAutocomplete];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return [[dictionary allKeys] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    char a = 'a'+section;
    NSString* key = [NSString stringWithFormat:@"%c",a];
  //  [[dictionary allKeys] objectAtIndex: section];
    NSArray* results = [dictionary objectForKey:key];
    return [results count];
}

- (void)placeAutocomplete:(NSString*)key {

    CLLocationCoordinate2D left= CLLocationCoordinate2DMake ( 44.437714,26.070900);
    CLLocationCoordinate2D right = CLLocationCoordinate2DMake (44.431278,26.082401);
    GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] initWithCoordinate:left coordinate:right];
    
    [_placesClient autocompleteQuery:key
                              bounds:bounds
                              filter:nil
                            callback:^(NSArray *results, NSError *error) {
                                if (error != nil) {
                                    NSLog(@"Autocomplete error %@", [error localizedDescription]);
                                    return;
                                }
                                
                                placesResults = [NSArray new];
                                placesResults = results;
                                [dictionary setObject:placesResults forKey:key];
                             /*   for (GMSAutocompletePrediction* result in placesResults) {
                                    NSLog(@"Result '%@' with placeID %@", result.attributedFullText.string, result.placeID);
                              
                                } */
                            [self.tableView reloadData];
                            }];
    
}

NSMutableDictionary* dictionary;

- (void) viewDidAppear:(BOOL)animated
{
    dictionary = [[NSMutableDictionary alloc] init];
    for(char a='a';a<='z';a++)
    {
        NSString *key = [NSString stringWithFormat:@"%c",a];
        
        [self placeAutocomplete:key];
        
    }
}



- (PlacesTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PlacesTableViewCell *cell;
    if(indexPath.row%2==0)
        cell = [tableView dequeueReusableCellWithIdentifier:@"evenCell"];
    else
        cell = [tableView dequeueReusableCellWithIdentifier:@"oddCell"];
    // Configure the cell...
    if(cell == nil)
    {
        if(indexPath.row%2 == 0)
        {
            cell = [[PlacesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"evenCell"];
        
        }
        else
        {
            cell = [[PlacesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"oddCell"];
        }
    }
   // [cell.textLabel setText: [NSString stringWithFormat:@"Cell no %ld", (long)indexPath.row]];
    //NSString* key = [[dictionary allKeys] objectAtIndex: indexPath.section];
    char a = 'a'+indexPath.section;
    NSString* key = [NSString stringWithFormat:@"%c",a];
    NSArray* results = [dictionary objectForKey:key];
     GMSAutocompletePrediction* result =  results[indexPath.row];
    [cell.label setText:[[result attributedFullText] string]];
    //[cell.textLabel setText:[[result attributedFullText] string]];
    
        return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    char a = 'A'+section;
    NSString* key = [NSString stringWithFormat:@"%c",a];
    NSString* name = [[NSString alloc] initWithFormat:@"Section - %@", key];
    return name;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 30;
}

NSIndexPath *selectedRow;
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedRow=indexPath;
    char a = 'a'+selectedRow.section;
    NSString* key = [NSString stringWithFormat:@"%c",a];
    NSArray* results = [dictionary objectForKey:key];
    NSString *placeID = [results[selectedRow.row] placeID];
    //  GMSPlace* thisPlace = [GMSPlace new];
    [_placesClient lookUpPlaceID:placeID callback:^(GMSPlace *place, NSError *error) {
        // thisPlace = place;
        if (error != nil) {
            NSLog(@"Place Details error %@", [error localizedDescription]);
            return;
        }
        
        if (place != nil) {
            NSLog(@"Place name %@", place.name);
            NSLog(@"Place address %@", place.formattedAddress);
            NSLog(@"Place placeID %@", place.placeID);
            NSLog(@"Place attributions %@", place.attributions);
        } else {
            NSLog(@"No place details for %@", placeID);
        }
        _place = place;
        [self performSegueWithIdentifier:@"showDetails" sender:self];
        
    }];
 
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqual:@"showDetails"])
    {
        DetailViewController *controller  = segue.destinationViewController;
        

         [controller setPlace: _place];
        


   
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
