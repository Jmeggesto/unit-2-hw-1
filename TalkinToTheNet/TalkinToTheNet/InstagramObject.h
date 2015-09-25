//
//  InstagramObject.h
//  TalkinToTheNet
//
//  Created by Jackie Meggesto on 9/24/15.
//  Copyright © 2015 Mike Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface InstagramObject : NSObject

@property (nonatomic) NSString *userName;
@property (nonatomic) NSString* caption;
@property (nonatomic) NSString* profilePicString;
@property (nonatomic) NSString* contentPicString;


-(instancetype)initWithJSON:(NSDictionary*)json;



@end
