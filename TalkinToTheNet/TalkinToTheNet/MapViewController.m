//
//  MapViewController.m
//  TalkinToTheNet
//
//  Created by Jackie Meggesto on 9/22/15.
//  Copyright © 2015 Mike Kavouras. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "APIManager.h"
#import "FoursquareObject.h"
#import "InstagramTableViewController.h"

@interface MapViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UIButton *instagramFeedButton;


@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = [NSString stringWithFormat:@"%@ near you", self.searchString];
    self.mapView.delegate = self;
    [self.instagramFeedButton setTitle:[NSString stringWithFormat:@"See who's talking about %@", self.searchString] forState:UIControlStateNormal];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 1150, 1150);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
    for(FoursquareObject* place in self.places){
        
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        point.coordinate = place.coordinate;
        point.title = place.name;
        point.subtitle = place.address;
        
        [self.mapView addAnnotation:point];
        
    }
    
}
- (IBAction)transitionToIGFeed:(id)sender {
    
    InstagramTableViewController* igTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"InstagramTVC"];
    igTVC.searchString = self.searchString;
    [self.navigationController pushViewController:igTVC animated:YES];
    
}


@end
