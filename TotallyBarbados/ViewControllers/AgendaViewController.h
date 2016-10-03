//
//  AgendaViewController.h
//  Totally Barabados
//
//  Created by Sudarshan on 6/21/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperViewController.h"
@interface AgendaViewController : SuperViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UITableView *tableVw;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UIButton *nextDateBtn;
@property (weak, nonatomic) IBOutlet UILabel *dateLbl;
@property (weak, nonatomic) IBOutlet UIButton *previoudDateBtn;
- (IBAction)nextDateBtnClicked:(id)sender;
- (IBAction)previousDateBtnClicked:(id)sender;
@end
