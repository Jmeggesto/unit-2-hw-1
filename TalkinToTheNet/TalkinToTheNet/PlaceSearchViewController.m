//
//  PlaceSearchViewController.m
//  TalkinToTheNet
//
//  Created by Jackie Meggesto on 9/22/15.
//  Copyright © 2015 Mike Kavouras. All rights reserved.
//

#import "PlaceSearchViewController.h"
#import "MapViewController.h"
#import "APIManager.h"
#import "FoursquareObject.h"
#import <CoreLocation/CoreLocation.h>

@interface PlaceSearchViewController () <UITextFieldDelegate, CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (nonatomic) NSMutableArray* apiResults;
@property (nonatomic) CLLocationManager* locationManager;
@property (nonatomic) NSString* longitude;
@property (nonatomic) NSString* latitude;


@end

@implementation PlaceSearchViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    self.searchTextField.delegate = self;
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager requestWhenInUseAuthorization];
    
    
    
    [self.locationManager startUpdatingLocation];
    
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField endEditing:YES];
    [self makeNewRequestWithSearchTerm:textField.text callBackBlock:^{
        
        MapViewController *mvc = [self.storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];
        mvc.places = self.apiResults;
        mvc.searchString = textField.text;
        [self.navigationController pushViewController:mvc animated:YES];
        
        
    }];
    
    
    return YES;
}

-(void)makeNewRequestWithSearchTerm:(NSString*)searchTerm callBackBlock:(void(^)())callBackBlock  {
    
    
    //search term
    //url (media = music, term = searchTerm
    NSString *URLString = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?client_id=VENOVOCEM4E1QVRTGNOCNO40V32YHQ4FMRD0M3K4WBMYQWPS&client_secret=QVM22AMEWXEZ54VBHMGOHYE2JNMMLTQYKOKOSAK0JTGDQBLT&v=20130815&ll=%@,%@&query=%@&radius=1000", self.latitude, self.longitude, searchTerm];
    NSString *encodedString = [URLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURL *requestURL = [NSURL URLWithString:encodedString];
    
    [APIManager GETRequestWithURL:requestURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        
        if (data != nil){
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            NSDictionary *response = [json objectForKey:@"response"];
            NSArray *venues = [response objectForKey:@"venues"];
            
            self.apiResults = [[NSMutableArray alloc]init];
            
            for(NSDictionary *venue in venues){
                
                NSString *longitude = [[venue objectForKey:@"location"] objectForKey:@"lng"];
                NSString *latitude =  [[venue objectForKey:@"location"] objectForKey:@"lat"];
                
                FoursquareObject *foursquareVenue = [[FoursquareObject alloc]init];
                foursquareVenue.name = [venue objectForKey:@"name"];
                foursquareVenue.address = [[venue objectForKey:@"location"] objectForKey:@"address"];
                foursquareVenue.coordinate = CLLocationCoordinate2DMake([latitude doubleValue], [longitude doubleValue]);
            
                
                
                [self.apiResults addObject:foursquareVenue];
                
                
            }
            
            callBackBlock();
        }
        
    }];
    
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    UIAlertView *errorMessage = [[UIAlertView alloc] initWithTitle:@"Error"
                                                           message:@"Location failure."
                                                          delegate:nil
                                                 cancelButtonTitle:@"Okay"
                                                 otherButtonTitles:nil];
    [errorMessage show];
    
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    CLLocation *location = locations.lastObject;
    self.longitude = [NSString stringWithFormat:@"%.8f", location.coordinate.longitude];
    self.latitude = [NSString stringWithFormat:@"%.8f", location.coordinate.latitude];
    
}

@end
