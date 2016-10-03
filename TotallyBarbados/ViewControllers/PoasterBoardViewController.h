//
//  PoasterBoardViewController.h
//  Totally Barabados
//
//  Created by Sudarshan on 6/21/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperViewController.h"
@interface PoasterBoardViewController : SuperViewController
@property (weak, nonatomic) IBOutlet UIButton *nextDateBtn;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionVw;
@property (weak, nonatomic) IBOutlet UILabel *dateLbl;
@property (weak, nonatomic) IBOutlet UIButton *previoudDateBtn;
- (IBAction)nextDateBtnClicked:(id)sender;
- (IBAction)previousDateBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@end
