//
//  PoasterBoardCollectionViewCell.h
//  TotallyBarbados
//
//  Created by Sudarshan on 6/23/16.
//  Copyright © 2016 Uniken. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
@interface PoasterBoardCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *semiDateLabel;
@property (weak, nonatomic) IBOutlet AsyncImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end
