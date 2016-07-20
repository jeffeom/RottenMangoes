//
//  Venue.h
//  RottenMangoes
//
//  Created by Jeff Eom on 2016-07-19.
//  Copyright © 2016 Jeff Eom. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MapKit;

@interface Venue : NSObject <MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly, copy, nullable) NSString *title;
@property (nonatomic, readonly, copy, nullable) NSString *subtitle;

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)aCoordinate andTitle:(NSString * _Nullable)aTitle andSubtitle:(NSString * _Nullable)aSubtitle;

@end
