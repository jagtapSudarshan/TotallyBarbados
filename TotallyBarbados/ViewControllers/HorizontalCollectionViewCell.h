//
//  HorizontalCollectionViewCell.h
//  TotallyBarbados
//
//  Created by Sudarshan on 6/23/16.
//  Copyright © 2016 Uniken. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HorizontalCollectionViewCell.h"
#import "AsyncImageView.h"
@interface HorizontalCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet AsyncImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *txtlbl;

@end
