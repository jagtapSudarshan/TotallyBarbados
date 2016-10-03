//
//  SecondaryViewController.h
//  TotallyBarbados
//
//  Created by Sudarshan on 6/27/16.
//  Copyright © 2016 Uniken. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondaryView.h"
#import <QuartzCore/QuartzCore.h>
#import "SuperViewController.h"
//
//typedef NS_ENUM(NSInteger, AlertButtonNumber) {
//  SINGLE_BUTTON_ALERT = 0,  /* SingleButton     */
//  Double_BUTTON_ALERT,     /* two Buttons       */
//};

@interface SecondaryViewController : UIViewController

@property (nonatomic, strong) SecondaryHeader *header;
@property (nonatomic, strong) SecondaryProcessingScreen *processingScreen;

-(void)addProccessingScreenWithText:(NSString*)text;
-(void)hideProcessingScreen;
-(void)setTitle:(NSString *)title;
-(void)showAlertwithTitle:(NSString*)title andMessage:(NSString*)message andTag:(int)tag andNumberOfbuttons:(AlertButtonNumber)number;
-(NSString*)base64EncodeString:(NSString*)plainString;
-(NSString*)base64DecodeString:(NSString*)base64encodedString;
-(NSString*)getCurrentDate;
-(NSString*)getPreviousDate;
-(NSString*)getNextDate;
-(NSString*)getEndDate;
//-(NSString*)dateToString:(NSString*)dateStr;

-(NSString*)getDatefromStrResponse:(NSString*)str;
-(NSString*)getMonthfromStrResponse:(NSString*)str;
-(NSString*)getYearfromStrResponse:(NSString*)str;
-(NSString*)getWeekDayfromStrResponse:(NSString*)str;

@end