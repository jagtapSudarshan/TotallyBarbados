//
//  SecondaryViewController.m
//  TotallyBarbados
//
//  Created by Sudarshan on 6/27/16.
//  Copyright © 2016 Uniken. All rights reserved.
//

#import "SecondaryViewController.h"
#import "RequestUtility.h"
#import "AppDelegate.h"
#import "SWRevealViewController.h"
@interface SecondaryViewController ()<UIAlertViewDelegate,UITextFieldDelegate>

@end

@implementation SecondaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  [self setupViews];
 
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NetworkConnectivity1) name:@"NetworkConnectivity" object:nil];
    // Do any additional setup after loading the view.
}
   -(void)setupViews{
     //  if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ){
     
     NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"SecondaryView" owner:self options:nil];
     
     for (UIView *view in nibObjects) {
 if ([view isKindOfClass:[SecondaryHeader class]]){
         
         self.header = (SecondaryHeader *)view;
         
         [self.view addSubview:self.header];
       }
       else if ([view isKindOfClass:[SecondaryProcessingScreen class]]){
         
         self.processingScreen = (SecondaryProcessingScreen *)view;
       }
       
     }
     //  }
   }
   
   - (void) NetworkConnectivity1 {
     [self hideProcessingScreen];
     
     [self showAlertwithTitle:kerrorparam andMessage:@"There does not seem to be any network connection available. Please check" andTag:0 andNumberOfbuttons:SINGLE_BUTTON_ALERT];
     
   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backButtonClick:(id)sender {
  [self.navigationController popViewControllerAnimated:YES];
}

-(void)addProccessingScreenWithText:(NSString*)text{
  self.processingScreen.hidden = NO;
  self.processingScreen.progressBar.progress = 0.0;
  self.processingScreen.activityIndicator.hidden = NO;
  [self.processingScreen.activityIndicator startAnimating];
  if (text) {
    [self.view addSubview:self.processingScreen];
    [self.processingScreen.progressLabel setText:text];
    [self.view bringSubviewToFront:self.processingScreen];
  }else{
    self.processingScreen.progressLabel.hidden = YES;
    self.processingScreen.activityIndicator.hidden = YES;
  }
  
}

-(void)addOnlyProcesSplashScreen{
  self.processingScreen.hidden = NO;
  [self.view addSubview:self.processingScreen];
  [self.view bringSubviewToFront:self.processingScreen];
  self.processingScreen.progressBar.hidden = YES;
  self.processingScreen.progressLabel.hidden = YES;
  self.processingScreen.activityIndicator.hidden = YES;
}

-(void)hideProcessingScreen{
  //  [self.processingScreen removeFromSuperview];
  [self.processingScreen.activityIndicator stopAnimating];
  self.processingScreen.hidden = YES;
  
}

- (void)setTitle:(NSString *)title {
  
  if (title) {
    self.header.titleLabel.hidden = NO;
    self.header.title = title;
  }else{
    self.header.titleLabel.hidden = YES;
  }
  
}

-(void)showAlertwithTitle:(NSString*)title andMessage:(NSString*)message andTag:(int)tag andNumberOfbuttons:(AlertButtonNumber)number{
  if (message.length>0) {
    UIAlertView *alertview;
    switch (number) {
      case 0:
        alertview = [[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alertview.tag = tag;
        [alertview show];
        break;
      case 1:
        alertview = [[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
        alertview.tag = tag;
        [alertview show];
        break;
        
      default:
        break;
    }
  }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
  
  if (alertView.tag==-1) {
    if (buttonIndex==0) {
      exit(0);
    }
  }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
  [textField resignFirstResponder];
  return YES;
}

-(NSString*)base64EncodeString:(NSString*)plainString{
  NSData *plainData = [plainString dataUsingEncoding:NSUTF8StringEncoding];
  NSString *base64String = [plainData base64EncodedStringWithOptions:0];
  NSLog(@"%@", base64String);
  return base64String;
}

-(NSString*)base64DecodeString:(NSString*)base64encodedString{
  NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:base64encodedString options:0];
  NSString *decodedString = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
  NSLog(@"%@", decodedString);
  return decodedString;
}

-(NSString*)getCurrentDate{
  NSDate *todayDate = [NSDate date]; // get today date
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; // here we create NSDateFormatter object for change the Format of date..
  [dateFormatter setDateFormat:@"yyyy-MM-dd"]; //Here we can set the format which we need
  NSString *convertedDateString = [dateFormatter stringFromDate:todayDate];// here convert date in
  NSLog(@"Today formatted date is %@",convertedDateString);
  return convertedDateString;
}

-(NSString*)getPreviousDate{
  NSDate *date = [NSDate date]; // your date from the server will go here.
  NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
  NSDateComponents *components = [[NSDateComponents alloc] init];
  components.day = -1;
  NSDate *newDate = [calendar dateByAddingComponents:components toDate:date options:0];
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; // here we create NSDateFormatter object for change the Format of date..
  [dateFormatter setDateFormat:@"yyyy-MM-dd"]; //Here we can set the format which we need
  NSString *convertedDateString = [dateFormatter stringFromDate:newDate];// here convert date in
  NSLog(@"previous formatted date is %@",convertedDateString);
  return convertedDateString;
}

-(NSString*)getEndDate{
  NSDate *date = [NSDate date]; // your date from the server will go here.
  NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
  NSDateComponents *components = [[NSDateComponents alloc] init];
  components.day = +3;
  NSDate *newDate = [calendar dateByAddingComponents:components toDate:date options:0];
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; // here we create NSDateFormatter object for change the Format of date..
  [dateFormatter setDateFormat:@"yyyy-MM-dd"]; //Here we can set the format which we need
  NSString *convertedDateString = [dateFormatter stringFromDate:newDate];// here convert date in
  NSLog(@"previous formatted date is %@",convertedDateString);
  return convertedDateString;
}

-(NSString*)getNextDate{
  NSDate *tomorrow = [NSDate dateWithTimeInterval:(24*60*60) sinceDate:[NSDate date]];
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; // here we create NSDateFormatter object for change the Format of date..
  [dateFormatter setDateFormat:@"yyyy-MM-dd"]; //Here we can set the format which we need
  NSString *convertedDateString = [dateFormatter stringFromDate:tomorrow];// here convert date in
  NSLog(@"Next formatted date is %@",convertedDateString);
  
  return @"10/2/2016";
}

-(NSString*)dateToString:(NSString*)dateStr{
  //  NSString *dateString = @"01-02-2010";
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  // this is imporant - we set our input date format to match our input string
  // if format doesn't match you'll get nil from your string, so be careful
  [dateFormatter setDateFormat:@"MM"];
  NSDate *dateFromString = [[NSDate alloc] init];
  // voila!
  dateFromString = [dateFormatter dateFromString:dateStr];
  
  NSDateFormatter *dateformate1=[[NSDateFormatter alloc]init];
  [dateformate1 setDateFormat:@"MM"]; // Date formater
  NSString *date = [dateformate1 stringFromDate:[NSDate date]]; // Convert date to string
  NSLog(@"date :%@",date);
  return [self monthfromString:date];
}

-(NSString*)monthfromString:(NSString*)str{
  NSDictionary *dateDict = @{@"JAN":@"01",@"FEB":@"02",@"MAR":@"03",@"APR":@"04",@"MAY":@"05",@"JUNE":@"06",@"JULY":@"07",@"AUG":@"08",@"SEP":@"09",@"OCT":@"10",@"NOV":@"11",@"DEC":@"12"};
  return [dateDict valueForKey:str];
}

-(NSString*)getDatefromStrResponse:(NSString*)str{
  NSDateFormatter *df = [[NSDateFormatter alloc] init];
  [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
  NSDate *myDate = [df dateFromString: str];
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:@"dd"];
  NSString *strDate = [formatter stringFromDate:myDate];
  return strDate;
}

-(NSString*)getMonthfromStrResponse:(NSString*)str{
  NSDateFormatter *df = [[NSDateFormatter alloc] init];
  [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
  NSDate *myDate = [df dateFromString: str];
  
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  //Get Month
  [formatter setDateFormat:@"MMM"];
  NSString *strMonth = [formatter stringFromDate:myDate];
  return strMonth;
}

-(NSString*)getYearfromStrResponse:(NSString*)str{
  NSDateFormatter *df = [[NSDateFormatter alloc] init];
  [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
  NSDate *myDate = [df dateFromString: str];
  
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  //Get Year
  [formatter setDateFormat:@"yyyy"];
  NSString *strYear = [formatter stringFromDate:myDate];
  return strYear;
}

-(NSString*)getWeekDayfromStrResponse:(NSString*)str{
  NSDateFormatter *df = [[NSDateFormatter alloc] init];
  [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
  NSCalendar* cal = [NSCalendar currentCalendar];
  NSDateComponents* comp = [cal components:NSCalendarUnitWeekday fromDate:[NSDate date]];
  NSInteger day =  [comp weekday];
  NSString *weekDaystr;
  switch (day) {
    case 0:
      weekDaystr = @"SUN";
      break;
    case 1:
      weekDaystr = @"MON";
      break;
    case 2:
      weekDaystr = @"TUE";
      break;
    case 3:
      weekDaystr = @"WED";
      break;
    case 4:
      weekDaystr = @"THU";
      break;
    case 5:
      weekDaystr = @"FRI";
      break;
    case 6:
      weekDaystr = @"SAT";
      break;
    default:
      break;
  }
  return weekDaystr;
}

-(void)viewDidDisappear:(BOOL)animated{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
