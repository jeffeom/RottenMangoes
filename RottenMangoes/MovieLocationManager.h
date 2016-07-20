//
//  MovieLocationManager.h
//  RottenMangoes
//
//  Created by Jeff Eom on 2016-07-19.
//  Copyright © 2016 Jeff Eom. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;
#import "Venue.h"

@interface MovieLocationManager : NSObject

+ (void)responseFromMLM:(CLLocation*)currentLocation movieAddress:(NSString*) movieAddress movieTitle:(NSString*)movieTitle block:(void (^)(NSArray *locationsArray, NSError *error))completionBlock;

@end
