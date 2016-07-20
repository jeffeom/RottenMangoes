//
//  MovieLocationManager.m
//  RottenMangoes
//
//  Created by Jeff Eom on 2016-07-19.
//  Copyright © 2016 Jeff Eom. All rights reserved.
//

#import "MovieLocationManager.h"

@implementation MovieLocationManager

+ (void)responseFromMLM:(CLLocation*)currentLocation movieAddress:(NSString*) movieAddress movieTitle:(NSString*)movieTitle block:(void (^)(NSArray *locationsArray, NSError *error))completionBlock{
    
    NSString *apiLighthouse= @"http://lighthouse-movie-showtimes.herokuapp.com/theatres.json";
    
    NSMutableURLRequest *MovieLocRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?address=%@&movie=%@",apiLighthouse,movieAddress, movieTitle]]];
    NSLog(@"%@", MovieLocRequest);
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:MovieLocRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error) {
            NSError *myJSONSerializationError = nil;
            
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&myJSONSerializationError];
            
            NSArray *theatresKeys = JSON[@"theatres"];
            
            NSMutableArray *venues = [NSMutableArray array];
            
            for(NSDictionary *aTheatre in theatresKeys){
                
                NSString *name = aTheatre[@"name"];
                NSString *address = aTheatre[@"address"];
                NSNumber *lat = aTheatre[@"lat"];
                NSNumber *lng = aTheatre[@"lng"];
                
                Venue *venue = [[Venue alloc] initWithCoordinate:CLLocationCoordinate2DMake([lat doubleValue], [lng doubleValue]) andTitle:name andSubtitle:address];
                
                [venues addObject:venue];
            }
            
            completionBlock(venues, nil);
        }else{
            completionBlock(nil, error);
        }
    }];
    
    [task resume];
    
}

@end
