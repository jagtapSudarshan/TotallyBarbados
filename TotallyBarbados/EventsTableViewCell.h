//
//  EventsTableViewCell.h
//  TotallyBarbados
//
//  Created by Sudarshan on 6/26/16.
//  Copyright © 2016 Uniken. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
@interface EventsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet AsyncImageView *imgVw;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *dateTimeDescriptionLbl;

@end
