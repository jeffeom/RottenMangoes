//
//  Movies.m
//  RottenMangoes
//
//  Created by Jeff Eom on 2016-07-18.
//  Copyright © 2016 Jeff Eom. All rights reserved.
//

#import "Movies.h"

@implementation Movies

- (instancetype)initWithTitle:(NSString *)title year:(NSNumber *)year reviewURL:(NSURL *)reviewURL critic:(NSString *)critic freshness:(NSString *)freshness andImageUrl:(NSURL *)imageUrl
{
    self = [super init];
    if (self) {
        _title = title;
        _year = year;
        _imageUrl = imageUrl;
        _reviewUrl = reviewURL;
        _critic = critic;
        _freshness = freshness;
    }
    return self;
}

@end
