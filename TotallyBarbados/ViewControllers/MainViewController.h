//
//  MainViewController.h
//  SidebarDemo
//
//  Created by Simon Ng on 10/11/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperViewController.h"
//typedef NS_ENUM(NSInteger, AlertButtonNumber) {
//  SINGLE_BUTTON_ALERT = 0,  /* SingleButton     */
//  Double_BUTTON_ALERT,     /* two Buttons       */
//};
@interface MainViewController : SuperViewController
- (IBAction)searchButtonPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (weak, nonatomic) IBOutlet UITextField *searchTextfld;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewHorizontal;
@property (weak, nonatomic) IBOutlet UICollectionView *cvV;
@property (nonatomic, strong) NSArray<NSURL *> *imageURLs;
@end


//@interface horizontalCell : UICollectionViewCell
//@property (weak, nonatomic) IBOutlet UIImageView *imgView;
//@property (weak, nonatomic) IBOutlet UILabel *textlbl;
//
//@end
//
//@interface VerticalCell : UICollectionViewCell

//@end