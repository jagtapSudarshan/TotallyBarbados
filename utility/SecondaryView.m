//
//  SecondaryView.m
//  TotallyBarbados
//
//  Created by Sudarshan on 6/27/16.
//  Copyright © 2016 Uniken. All rights reserved.
//

#import "SecondaryView.h"
#import <QuartzCore/QuartzCore.h>
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
@implementation SecondaryView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

@implementation SecondaryHeader

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

@implementation SecondaryProcessingScreen

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