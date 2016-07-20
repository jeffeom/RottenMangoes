//
//  MyLocationManager.h
//  RottenMangoes
//
//  Created by Jeff Eom on 2016-07-19.
//  Copyright © 2016 Jeff Eom. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
@import CoreLocation;

@protocol MyLocationManagerDelegate <NSObject>

- (void)newLocationDetected:(CLLocation *) location;

@end

@interface MyLocationManager : NSObject <CLLocationManagerDelegate>

@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic) CLLocation *currentLocation;

@property (nonatomic) NSString *postalCode;

@property (nonatomic, weak) id <MyLocationManagerDelegate> delegate;

+ (id)sharedManager;
- (void)startLocationMonitoring;

@end
