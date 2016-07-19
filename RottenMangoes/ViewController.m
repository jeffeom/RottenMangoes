//
//  ViewController.m
//  RottenMangoes
//
//  Created by Jeff Eom on 2016-07-18.
//  Copyright © 2016 Jeff Eom. All rights reserved.
//

#import "ViewController.h"
#import "Movies.h"
#import "MyCollectionViewCell.h"
#import "ReviewViewController.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property NSArray *objects;

@property NSURLSession *session;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    NSString *urlString = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?apikey=xe4xau69pxaah5tmuryvrw75&page_limit=50";
    
    NSURLSession *session = [NSURLSession sharedSession];
    self.session = session;
    
    NSURLSessionTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error){
            NSError *jsonError = nil;
            
            NSDictionary *movies = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            
            if (![movies isKindOfClass:[NSDictionary class]]) {
                NSLog(@"abort!!");
                return;
            }
            
            NSArray *moviesKey = movies[@"movies"];
            
            NSMutableArray *movieLists = [NSMutableArray array];
            
            //            NSDictionary *aMovie = moviesKey[0];
            
            for(NSDictionary *aMovie in moviesKey){
                
                NSString *title = aMovie[@"title"];
                NSNumber *year = aMovie[@"year"];
                NSDictionary *posters = aMovie[@"posters"];
                NSURL *imageUrl = [NSURL URLWithString: posters[@"original"]];
                NSDictionary *links = aMovie[@"links"];
                NSString *stringURLWithKey = [links[@"reviews"] stringByAppendingString:@"?apikey=j9fhnct2tp8wu2q9h75kanh9&page_limit=3" ];
                NSString *newStringURL = [stringURLWithKey stringByReplacingOccurrencesOfString:@"https" withString:@"http"];
                NSURL *reviewURL = [NSURL URLWithString: newStringURL];
                
                Movies *movies = [[Movies alloc] initWithTitle:title year:year reviewURL:reviewURL critic:nil freshness:nil andImageUrl:imageUrl];
                
                [movieLists addObject:movies];
            }
            
            self.objects = movieLists;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
            });
            
        }
    }];
    
    [dataTask resume];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Collection View

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.objects.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    Movies *movie = self.objects[indexPath.row];
    
    cell.titleLabel.text = movie.title;
    cell.yearLabel.text = [NSString stringWithFormat:@"%@", movie.year];

    
    // create a url session task
    
    // in the completion block translate your data to a UIImage
    // give that image to the cell.
    
    // NSData *data =[NSData dataWithContentsOfURL:[NSURL URLWithString:movie.imageURL]];
    
    NSURLSessionDataTask *imageTask = [self.session dataTaskWithURL:movie.imageUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(!error){
            
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.imageView.image = [UIImage imageWithData:data];
            });
        }
    }];
    
    [imageTask resume];
    
    return cell;
    
}

#pragma mark - Segue

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"showReview" sender:self.objects[indexPath.item]];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(Movies *)sender{
    if([[segue identifier] isEqualToString:@"showReview"]){
        [[segue destinationViewController] setDetailItem:sender];
    }
}

@end
