//
//  CustomView.h
//  RELID_STOCK
//
//  Created by Sudarshan on 10/26/15.
//  Copyright (c) 2015 sudarshan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CustomView : UIView

@end

@interface Header : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIImageView *Imagelogo;
@property(nonatomic,copy)NSString *title;
- (void)setTitle:(NSString *)title;

@end

@interface Footer : UIView

@property (weak, nonatomic) IBOutlet UIImageView *footerImage;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;

@end

@interface ProcessingScreen : UIView

@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressBar;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@interface UIlabelDarkBlueColor : UILabel

@end

@interface UILabelGreyColor : UILabel

@end

@interface UILabellightBlueColor : UILabel

@end

@interface UICustomBarButton : UIButton

@end

@interface UICustomButton : UIButton

@end

@interface UIViewBorder : UIView

@end

@interface UICustomTextfield : UITextField

@end

@interface GreenBordertextfield : UITextField

@end

@interface BlueBordertextView : UITextView

@end

@interface UIColor (Colour)

+ (UIColor*)colorWith8BitRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha;

+ (UIColor*)colorWithHex:(NSString*)hex alpha:(CGFloat)alpha;

@end
