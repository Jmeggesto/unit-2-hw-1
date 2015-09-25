//
//  FoursquareObject.h
//  TalkinToTheNet
//
//  Created by Jackie Meggesto on 9/23/15.
//  Copyright © 2015 Mike Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface FoursquareObject : NSObject
@property (nonatomic) NSString* name;
@property (nonatomic) NSString* address;
@property (nonatomic) CLLocationCoordinate2D coordinate;

@end
