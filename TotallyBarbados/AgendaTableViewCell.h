//
//  AgendaTableViewCell.h
//  TotallyBarbados
//
//  Created by Sudarshan on 6/26/16.
//  Copyright © 2016 Uniken. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AgendaTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *descriptionLbl;
@property (weak, nonatomic) IBOutlet UILabel *dateTimeLbl;

@end
