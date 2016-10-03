//
//  SecondaryView.h
//  TotallyBarbados
//
//  Created by Sudarshan on 6/27/16.
//  Copyright © 2016 Uniken. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondaryView : UIView

@end

@interface SecondaryHeader : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIImageView *Imagelogo;
@property(nonatomic,copy)NSString *title;
- (void)setTitle:(NSString *)title;

@end

@interface SecondaryProcessingScreen : UIView
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressBar;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end