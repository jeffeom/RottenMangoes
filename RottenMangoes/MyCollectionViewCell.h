//
//  MyCollectionViewCell.h
//  RottenMangoes
//
//  Created by Jeff Eom on 2016-07-18.
//  Copyright © 2016 Jeff Eom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
