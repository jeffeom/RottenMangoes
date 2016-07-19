//
//  Movies.h
//  RottenMangoes
//
//  Created by Jeff Eom on 2016-07-18.
//  Copyright © 2016 Jeff Eom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movies : NSObject

@property (nonatomic) NSString *title;
@property (nonatomic) NSNumber *year;
@property (nonatomic) NSURL *imageUrl;
@property (nonatomic) NSURL *reviewUrl;
@property (nonatomic) NSString *critic;
@property (nonatomic) NSString *freshness;


- (instancetype)initWithTitle:(NSString *)title year:(NSNumber *)year reviewURL:(NSURL *)reviewURL critic:(NSString *)critic freshness:(NSString *)freshness andImageUrl:(NSURL *)imageUrl;

@end
