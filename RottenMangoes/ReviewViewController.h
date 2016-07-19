//
//  ReviewViewController.h
//  RottenMangoes
//
//  Created by Jeff Eom on 2016-07-18.
//  Copyright © 2016 Jeff Eom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movies.h"

@interface ReviewViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *firstCLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondCLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdCLabel;

@property (nonatomic) Movies *detailItem;

@property NSMutableArray *critics;


@end
