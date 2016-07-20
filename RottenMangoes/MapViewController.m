//
//  MapViewController.m
//  RottenMangoes
//
//  Created by Jeff Eom on 2016-07-19.
//  Copyright © 2016 Jeff Eom. All rights reserved.
//

#import "MapViewController.h"
#import "MyLocationManager.h"
//#import "FourSquareManager.h"
#import "MovieLocationManager.h"
@import MapKit;

#define zoominMapArea 2100

@interface MapViewController() <MKMapViewDelegate, MyLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic) MyLocationManager *locationManager;


@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initiateMap];
    
}

-(void) initiateMap {
    self.locationManager = [MyLocationManager sharedManager];
    [self.locationManager startLocationMonitoring];
    self.locationManager.delegate = self;
    
}

-(void)newLocationDetected:(CLLocation *)location{
    
    CLLocationCoordinate2D zoomLocation = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
    
    MKCoordinateRegion adjustedRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, zoominMapArea, zoominMapArea);
    
    [_mapView setRegion:adjustedRegion animated:YES];
    
    NSString *newTitleString = [self.detailItem.title stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    NSString *newAddressString = [self.locationManager.postalCode stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    [MovieLocationManager responseFromMLM:location movieAddress:newAddressString movieTitle:newTitleString block:^(NSArray *locationsArray, NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.mapView addAnnotations:locationsArray];
        });
    }];
    
}

-(void)mapViewDidFinishLoadingMap:(MKMapView *)mapView{
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
