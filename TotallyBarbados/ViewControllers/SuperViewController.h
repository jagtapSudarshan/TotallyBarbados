//
//  SuperViewController.h
//  API_SDK_SAMPLE_V1
//
//  Created by Sudarshan on 10/26/15.
//  Copyright © 2015 Uniken India Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomView.h"
#import <QuartzCore/QuartzCore.h>

typedef NS_ENUM(NSInteger, AlertButtonNumber) {
  SINGLE_BUTTON_ALERT = 0,  /* SingleButton     */
  Double_BUTTON_ALERT,     /* two Buttons       */
};

@interface SuperViewController : UIViewController

@property (nonatomic, strong) Header *header;
@property (nonatomic, strong) Footer *footer;
@property (nonatomic, strong) ProcessingScreen *processingScreen;

-(void)addProccessingScreenWithText:(NSString*)text;
-(void)hideProcessingScreen;
-(void)setTitle:(NSString *)title;
-(void)showAlertwithTitle:(NSString*)title andMessage:(NSString*)message andTag:(int)tag andNumberOfbuttons:(AlertButtonNumber)number;
-(void)hideLogoutButton:(BOOL)hide;
- (IBAction)logoutButtonClick:(id)sender;
- (IBAction)backButtonClick:(id)sender;
-(NSString*)base64EncodeString:(NSString*)plainString;
-(NSString*)base64DecodeString:(NSString*)base64encodedString;
-(NSString*)getCurrentDate;
-(NSString*)getPreviousDate:(NSString*)cDate;
-(NSString*)getNextDate:(NSString*)cDate;
-(NSString*)getEndDate:(NSString*)cDate;
//-(NSString*)dateToString:(NSString*)dateStr;

-(NSString*)getDatefromStrResponse:(NSString*)str;
-(NSString*)getMonthfromStrResponse:(NSString*)str;
-(NSString*)getYearfromStrResponse:(NSString*)str;
-(NSString*)getWeekDayfromStrResponse:(NSString*)str;

-(NSString*)getDateToDisplayfromStrResponse:(NSString*)str;
-(NSString*)getMonthToDisplayfromStrResponse:(NSString*)str;
-(NSString*)getYearToDisplayfromStrResponse:(NSString*)str;
@end
