//
//  CustomView.m
//  RELID_STOCK
//
//  Created by Sudarshan on 10/26/15.
//  Copyright (c) 2015 sudarshan. All rights reserved.
//

#import "CustomView.h"
#import <QuartzCore/QuartzCore.h>
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
@implementation CustomView

@end

@implementation Footer

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    
    [self setupView];
    
  }
  return self;
}

- (instancetype)init {
  
  self = [super init];
  
  if (self) {
    
    [self setupView];
  }
  return self;
}

- (void)awakeFromNib {
  
  [super awakeFromNib];
  [self setupView];
  
}

- (void)setupView {
  
  float y;
  float width;
  if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ){
    //        float screenHeight =[self screenSize].height;
    //        y = screenHeight - self.frame.size.height;
    self.frame = CGRectMake(0, 718, 1024, 50);
    
  }else{
    float screenHeight =[self screenSize].height;
    y = screenHeight - self.frame.size.height;
    width = [self screenSize].width;
    CGRect footerFrame = self.frame;
    footerFrame.origin.x = 0;
    footerFrame.origin.y = y;
    footerFrame.size.width = width;
    self.frame = footerFrame;
  }
}

- (CGSize)screenSize
{
  CGSize screenSize = [UIScreen mainScreen].bounds.size;
  if ((NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1) && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
    return CGSizeMake(screenSize.height, screenSize.width);
  } else {
    return screenSize;
  }
}

@end


@implementation Header

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    [self setupView];
    
  }
  return self;
}

- (instancetype)init {
  
  self = [super init];
  
  if (self) {
    
    [self setupView];
  }
  return self;
}

- (void)awakeFromNib {
  
  [super awakeFromNib];
  [self setupView];
  
}

- (void)setupView {
  float width;
  if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ){
    self.frame = CGRectMake(0, 0, 1024, 40);
  }else{
    width = [self screenSize].width;
    CGRect footerFrame = self.frame;
    footerFrame.origin.x = 0;
    footerFrame.origin.y = 0;
    footerFrame.size.width = width;
    footerFrame.size.height = 40;
    self.frame = footerFrame;
  }
}

- (CGSize)screenSize
{
  CGSize screenSize = [UIScreen mainScreen].bounds.size;
  if ((NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1) && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
    return CGSizeMake(screenSize.height, screenSize.width);
  } else {
    return screenSize;
  }
}

- (void)setTitle:(NSString *)title {
  
  if ([title length] > 0) {
    
    self.titleLabel.text = title;
  }
  
  
}

@end

@implementation ProcessingScreen

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    [self setupView];
    
  }
  return self;
}

- (instancetype)init {
  
  self = [super init];
  
  if (self) {
    
    [self setupView];
  }
  return self;
}

- (void)awakeFromNib {
  
  [super awakeFromNib];
  [self setupView];
  
}

- (void)setupView {
  if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ){
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    [self setFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];
    self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
  }else{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    if (SYSTEM_VERSION_LESS_THAN(@"8.0")) {
      [self setFrame:CGRectMake(0, 0, screenSize.height, screenSize.width)];
    }else{
      [self setFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];
    }
    self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
  }
}

- (CGSize)screenSize
{
  CGSize screenSize = [UIScreen mainScreen].bounds.size;
  if ((NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1) && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
    return CGSizeMake(screenSize.height, screenSize.width);
  } else {
    return screenSize;
  }
}
@end

@implementation UIlabelDarkBlueColor

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code
  }
  return self;
}

-(void) drawRect:(CGRect)rect
{
  
  self.textColor = [UIColor colorWithHex:@"#014b7A" alpha:1];
  
  [super drawRect:rect];
  
  if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
    self.preferredMaxLayoutWidth = 0;
  }
}

@end

@implementation UILabelGreyColor

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code
  }
  return self;
}

-(void) drawRect:(CGRect)rect
{
  
  self.textColor = [UIColor colorWithHex:@"#ADBCCA" alpha:1];
  if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
    self.preferredMaxLayoutWidth = 0;
  }
  [super drawRect:rect];
}

@end

@implementation UILabellightBlueColor

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code
  }
  return self;
}

-(void) drawRect:(CGRect)rect
{
  
  self.textColor = [UIColor colorWithHex:@"#1BA2C1" alpha:1];
  if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
    self.preferredMaxLayoutWidth = 0;
  }
  [super drawRect:rect];
}

@end

@implementation UICustomBarButton

- (void)awakeFromNib {
  
  [self setTitleColor:[UIColor colorWithHex:@"#014b7A" alpha:1] forState:UIControlStateNormal];
}

@end

@implementation UICustomButton

- (void)awakeFromNib {
  
  [self setTitleColor:[UIColor colorWithHex:@"#FFFFFF" alpha:1] forState:UIControlStateNormal];
  self.backgroundColor = [UIColor colorWithHex:@"#3399FF" alpha:1];
  
  if (([self.titleLabel.text isEqual:@"Clear Saved UserID"])||([self.titleLabel.text isEqual:@"Clear User Data"])) {
    self.titleLabel.font = [UIFont fontWithName:@"Regular" size:12];
  }else{
    self.titleLabel.font = [UIFont fontWithName:@"Regular" size:18];
  }
  self.layer.cornerRadius = 8.0;
}

@end

@implementation UIViewBorder

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    [self setupAppearance];
  }
  return self;
}

- (void)awakeFromNib
{
  [self setupAppearance];
}

- (void)setupAppearance
{
  CGFloat borderWidth;
  if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ){
    borderWidth = 0.5f;
  }else{
    borderWidth = 1.0f;
  }
  self.frame = CGRectInset(self.frame, -borderWidth, -borderWidth);
  self.layer.borderColor = [UIColor grayColor].CGColor;
  self.layer.borderWidth = borderWidth;
}

@end


@implementation UICustomTextfield

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    [self setupAppearance];
  }
  return self;
}

- (void)awakeFromNib
{
  [super awakeFromNib];
  self.delegate = self.delegate;
  [self setupAppearance];
}

- (void)setupAppearance
{
  self.autocorrectionType = FALSE; // or use  UITextAutocorrectionTypeNo
  self.autocapitalizationType = UITextAutocapitalizationTypeNone;
  self.layer.cornerRadius=2.0f;
  self.layer.masksToBounds=YES;
  self.layer.borderColor=[[UIColor colorWithHex:@"#1189DE" alpha:1]CGColor];
  self.layer.borderWidth= 1.0f;
  
}

@end


@implementation GreenBordertextfield

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    [self setupAppearance];
  }
  return self;
}

- (void)awakeFromNib
{
  [super awakeFromNib];
  self.delegate = self.delegate;
  [self setupAppearance];
}

- (void)setupAppearance
{
  self.autocorrectionType = FALSE; // or use  UITextAutocorrectionTypeNo
  self.autocapitalizationType = UITextAutocapitalizationTypeNone;
  self.layer.cornerRadius=1.0f;
  self.layer.masksToBounds=YES;
  self.layer.borderColor=[[UIColor colorWithHex:@"#99CC33" alpha:1]CGColor];
  self.layer.borderWidth= 1.0f;
  
}

@end



@implementation BlueBordertextView

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    [self setupAppearance];
  }
  return self;
}

- (void)awakeFromNib
{
  [super awakeFromNib];
  self.delegate = self.delegate;
  [self setupAppearance];
}

- (void)setupAppearance
{
  self.autocorrectionType = FALSE; // or use  UITextAutocorrectionTypeNo
  self.autocapitalizationType = UITextAutocapitalizationTypeNone;
  self.layer.cornerRadius=1.0f;
  self.layer.masksToBounds=YES;
  self.layer.borderColor=[[UIColor colorWithHex:@"#1189DE" alpha:1]CGColor];
  self.layer.borderWidth= 1.0f;
  
}

@end

@implementation UIColor (Colour)

+ (UIColor*)colorWith8BitRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha {
  return [UIColor colorWithRed:(red/255.0) green:(green/255.0) blue:(blue/255.0) alpha:alpha];
}

+ (UIColor*)colorWithHex:(NSString*)hex alpha:(CGFloat)alpha {
  
  assert(7 == [hex length]);
  assert('#' == [hex characterAtIndex:0]);
  
  NSString *redHex = [NSString stringWithFormat:@"0x%@", [hex substringWithRange:NSMakeRange(1, 2)]];
  NSString *greenHex = [NSString stringWithFormat:@"0x%@", [hex substringWithRange:NSMakeRange(3, 2)]];
  NSString *blueHex = [NSString stringWithFormat:@"0x%@", [hex substringWithRange:NSMakeRange(5, 2)]];
  
  unsigned redInt = 0;
  NSScanner *rScanner = [NSScanner scannerWithString:redHex];
  [rScanner scanHexInt:&redInt];
  
  unsigned greenInt = 0;
  NSScanner *gScanner = [NSScanner scannerWithString:greenHex];
  [gScanner scanHexInt:&greenInt];
  
  unsigned blueInt = 0;
  NSScanner *bScanner = [NSScanner scannerWithString:blueHex];
  [bScanner scanHexInt:&blueInt];
  
  return [UIColor colorWith8BitRed:redInt green:greenInt blue:blueInt alpha:alpha];
}


@end
