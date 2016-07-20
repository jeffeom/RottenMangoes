//
//  ReviewViewController.m
//  RottenMangoes
//
//  Created by Jeff Eom on 2016-07-18.
//  Copyright © 2016 Jeff Eom. All rights reserved.
//

#import "ReviewViewController.h"

@implementation ReviewViewController

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
//        self.titleLabel.text = self.detailItem.critic;
//        self.yearLabel.text = self.detailItem.freshness;
        self.firstCLabel.text = self.critics[0];
        self.secondCLabel.text = self.critics[1];
        self.thirdCLabel.text = self.critics[2];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSURLSession *session = [NSURLSession sharedSession];

    NSURLSessionTask *reviewTask = [session dataTaskWithURL:self.detailItem.reviewUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error){
            NSError *jsonError = nil;
            
            NSDictionary *reviews = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            
            if (![reviews isKindOfClass:[NSDictionary class]]) {
                NSLog(@"abort!!");
                return;
            }
            
            NSArray *reviewsKey = reviews[@"reviews"];
            self.critics = [[NSMutableArray alloc] init];
            
            for(NSDictionary *aReview in reviewsKey){
                self.detailItem.critic = aReview[@"critic"];
                self.detailItem.freshness = aReview[@"freshness"];
                NSString *criticString = self.detailItem.critic;
                NSString *criticStringSpace = [criticString stringByAppendingString:@": "];
                NSString *combinedString = [criticStringSpace stringByAppendingString:self.detailItem.freshness];
                [self.critics addObject:combinedString];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self configureView];
            });
        }
    }];
    
    [reviewTask resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    Movies *movie = self.detailItem;
    if([[segue identifier] isEqualToString:@"showMap"]){
        [[segue destinationViewController] setDetailItem:movie];
    }
}

@end
