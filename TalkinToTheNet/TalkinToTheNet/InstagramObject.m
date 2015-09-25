//
//  InstagramObject.m
//  TalkinToTheNet
//
//  Created by Jackie Meggesto on 9/24/15.
//  Copyright © 2015 Mike Kavouras. All rights reserved.
//

#import "InstagramObject.h"

@implementation InstagramObject

-(instancetype)initWithJSON:(NSDictionary*)json {
    
    if(self = [super init]) {
        self.caption = json[@"caption"][@"text"];
        self.userName = json[@"user"][@"username"];
        self.profilePicString = json[@"user"][@"profile_picture"];
        self.contentPicString = json[@"images"][@"standard_resolution"][@"url"];
        
        return self;
    }
    return nil;
    
}

@end
