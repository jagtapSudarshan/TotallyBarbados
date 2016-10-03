//
//  SuperViewController.m
//  API_SDK_SAMPLE_V1
//
//  Created by Sudarshan on 10/26/15.
//  Copyright © 2015 Uniken India Pvt Ltd. All rights reserved.
//

#import "SuperViewController.h"
#import "RequestUtility.h"
#import "AppDelegate.h"
#import "SWRevealViewController.h"
@interface SuperViewController ()<UIAlertViewDelegate,UITextFieldDelegate>{
  
  UIButton *backNavigationbutton;
}

@end

@implementation SuperViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setupViews];
//  [self getCurrentDate];
//  [self getPreviousDate];
//  [self getNextDate];

  
  SWRevealViewController *revealViewController = self.revealViewController;
  if ( revealViewController )
  {
//    [self.header.cancelButton setTarget: self.revealViewController];
//    [self.header.cancelButton setAction: @selector( revealToggle: )];
    [self.header.cancelButton addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
  }
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NetworkConnectivity1) name:@"NetworkConnectivity" object:nil];
  self.footer.versionLabel.text = [NSString stringWithFormat:@"Version %@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]];
}

-(void)setupViews{
//  if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ){
  
    NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"CustomView_iPhone" owner:self options:nil];
    
    for (UIView *view in nibObjects) {
      
      if ([view isKindOfClass:[Footer class]]) {
        
        self.footer = (Footer *)view;
        
//        [self.view addSubview:self.footer];
      }
      else if ([view isKindOfClass:[Header class]]){
        
        self.header = (Header *)view;
        
        [self.view addSubview:self.header];
      }
      else if ([view isKindOfClass:[ProcessingScreen class]]){
        
        self.processingScreen = (ProcessingScreen *)view;
      }
      
    }
//  }
}

- (void) NetworkConnectivity1 {
  [self hideProcessingScreen];
  
  [self showAlertwithTitle:kerrorparam andMessage:@"There does not seem to be any network connection available. Please check" andTag:0 andNumberOfbuttons:SINGLE_BUTTON_ALERT];
  
}

-(void)hideLogoutButton:(BOOL)hide{
  if (hide){
    self.header.cancelButton.hidden = YES;
    [self addBackButton];
  }else{
    self.header.cancelButton.hidden = NO;
  }
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

- (IBAction)logoutButtonClick:(id)sender{
  [self showAlertwithTitle:nil andMessage:@"Do you want to Log Out" andTag:-1 andNumberOfbuttons:Double_BUTTON_ALERT];
}

-(void)addBackButton{
  backNavigationbutton = [UIButton buttonWithType:UIButtonTypeCustom];
  [backNavigationbutton addTarget:self
                           action:@selector(goback)
                 forControlEvents:UIControlEventTouchUpInside];
  [backNavigationbutton setImage:[UIImage imageNamed:@"back-1"] forState:UIControlStateNormal];
  CGRect buttonFrame = self.header.cancelButton.frame;
  buttonFrame.size = CGSizeMake(30, 30);
  backNavigationbutton.frame = buttonFrame;
  [self.header addSubview:backNavigationbutton];
  
}

-(void)goback{
  [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)backButtonClick:(id)sender {
  [self.navigationController popViewControllerAnimated:YES];
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

-(NSString*)getPreviousDate:(NSString*)cDate{

  NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
  [dateFormatter1 setDateFormat:@"yyyy-MM-dd"];
  NSDate *date = [dateFormatter1 dateFromString:cDate];
  
//  NSDate *date = [NSDate date]; // your date from the server will go here.
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

-(NSString*)getEndDate:(NSString*)cDate{
  
  
  NSDate *today = [NSDate date]; //Get a date object for today's date
  NSCalendar *c = [NSCalendar currentCalendar];
  NSRange days = [c rangeOfUnit:NSCalendarUnitDay
                         inUnit:NSCalendarUnitMonth
                        forDate:today];
  
  
  NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
  [dateFormatter1 setDateFormat:@"yyyy-MM-dd"];
  NSDate *date = [dateFormatter1 dateFromString:cDate];
//  NSDate *date = [NSDate date]; // your date from the server will go here.
  NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
  NSDateComponents *components = [[NSDateComponents alloc] init];
  components.day = +3;
  NSDate *newDate = [calendar dateByAddingComponents:components toDate:date options:0];
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; // here we create NSDateFormatter object for change the Format of date..
  [dateFormatter setDateFormat:@"yyyy-MM"]; //Here we can set the format which we need
  NSString *convertedDateString = [dateFormatter stringFromDate:newDate];// here convert date in
  NSLog(@"previous formatted date is %@",convertedDateString);
  convertedDateString = [NSString stringWithFormat:@"%@-%lu",convertedDateString,(unsigned long)days.length];
  return convertedDateString;
}

-(NSString*)getNextDate:(NSString*)cDate{
  NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
  [dateFormatter1 setDateFormat:@"yyyy-MM-dd"];
  NSDate *date = [dateFormatter1 dateFromString:cDate];
//  NSDate *date = [NSDate date]; // your date from the server will go here.
  NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
  NSDateComponents *components = [[NSDateComponents alloc] init];
  components.day = +1;
  NSDate *newDate = [calendar dateByAddingComponents:components toDate:date options:0];
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; // here we create NSDateFormatter object for change the Format of date..
  [dateFormatter setDateFormat:@"yyyy-MM-dd"]; //Here we can set the format which we need
  NSString *convertedDateString = [dateFormatter stringFromDate:newDate];// here convert date in
  NSLog(@"previous formatted date is %@",convertedDateString);
  return convertedDateString;
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
  
  NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
  // this is imporant - we set our input date format to match our input string
  // if format doesn't match you'll get nil from your string, so be careful
  [dateFormatter1 setDateFormat:@"yyyy-MM-dd"];
  NSDate *dateFromString = [[NSDate alloc] init];
  // voila!
  dateFromString = [dateFormatter1 dateFromString:str];
  
  NSDateFormatter *df = [[NSDateFormatter alloc] init];
  [df setDateFormat:@"yyyy-MM-dd"];
  NSCalendar* cal = [NSCalendar currentCalendar];
  NSDateComponents* comp = [cal components:NSCalendarUnitWeekday fromDate:dateFromString];
  NSInteger day =  [comp weekday];
  NSString *weekDaystr;
  switch (day) {
    
    case 1:
      weekDaystr = @"SUN";
      break;
    case 2:
      weekDaystr = @"MON";
      break;
    case 3:
      weekDaystr = @"TUE";
      break;
    case 4:
      weekDaystr = @"WED";
      break;
    case 5:
      weekDaystr = @"THU";
      break;
    case 6:
      weekDaystr = @"FRI";
      break;
    case 7:
      weekDaystr = @"SAT";
      break;
    default:
      break;
  }
  return weekDaystr;
}


-(NSString*)getDateToDisplayfromStrResponse:(NSString*)str{
  NSDateFormatter *df = [[NSDateFormatter alloc] init];
  [df setDateFormat:@"yyyy-MM-dd"];
  NSDate *myDate = [df dateFromString: str];
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:@"dd"];
  NSString *strDate = [formatter stringFromDate:myDate];
  return strDate;
}

-(NSString*)getMonthToDisplayfromStrResponse:(NSString*)str{
  NSDateFormatter *df = [[NSDateFormatter alloc] init];
  [df setDateFormat:@"yyyy-MM-dd"];
  NSDate *myDate = [df dateFromString: str];
  
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  //Get Month
  [formatter setDateFormat:@"MMM"];
  NSString *strMonth = [formatter stringFromDate:myDate];
  return strMonth;
}

-(NSString*)getYearToDisplayfromStrResponse:(NSString*)str{
  NSDateFormatter *df = [[NSDateFormatter alloc] init];
  [df setDateFormat:@"yyyy-MM-dd"];
  NSDate *myDate = [df dateFromString: str];
  
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  //Get Year
  [formatter setDateFormat:@"yyyy"];
  NSString *strYear = [formatter stringFromDate:myDate];
  return strYear;
}




- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

-(void)viewDidDisappear:(BOOL)animated{
[[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
