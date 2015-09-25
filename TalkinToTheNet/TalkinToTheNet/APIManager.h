//
//  APIManager.h
//  LearnAPIApp
//
//  Created by Jackie Meggesto on 9/20/15.
//  Copyright © 2015 Jackie Meggesto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIManager : NSObject

+ (void)GETRequestWithURL:(NSURL*)URL
        completionHandler:(void(^)(NSData* data, NSURLResponse* response, NSError* error))
        completionHandler;

@end
