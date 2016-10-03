//
//  CategoryDetailViewController.m
//  TotallyBarbados
//
//  Created by Sudarshan on 6/26/16.
//  Copyright © 2016 Uniken. All rights reserved.
//

#import "CategoryDetailViewController.h"
#import "CategoriesTableViewCell.h"
#import "RequestUtility.h"
#import "ResponseUtility.h"
#import "SearchTableViewCell.h"
#import "DetailViewController.h"
@interface CategoryDetailViewController (){
NSString *selectedPostID;
}

@end

@implementation CategoryDetailViewController
@synthesize detailLbl,detailText,cdate,cedate,cid;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"TOTALLY BARBADOS";
    self.detailLbl.text = detailText;
    self.navigationController.navigationBarHidden = YES;
    // Do any additional setup after loading the view.
//  [self getDetailCategoriesData];

}

//-(void)getDetailCategoriesData{
//  NSDictionary *params = @{@"current_date":self.cdate,@"end_date":self.cedate,@"category_id":cid};
////  [self addProccessingScreenWithText:@"Please wait.."];
//  RequestUtility *utility = [RequestUtility sharedRequestUtility];
//  NSString *url = @"http://developdreamz.com.md-70.webhostbox.net/barbados/category_events.php";
//  [utility doPostRequestfor:url withParameters:params onComplete:^(bool status, NSDictionary *responseDictionary){
//    if (status) {
//      NSLog(@"response:%@",responseDictionary);
//      [self parseSearchDetailsInfoResponse:responseDictionary];
//    }else{
////      [self hideProcessingScreen];
//    }
//  }];
//}
//
//
//-(void)parseSearchDetailsInfoResponse:(NSDictionary*)ResponseDictionary{
//  if (ResponseDictionary) {
//    NSError * err;
//    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:ResponseDictionary options:0 error:&err];
//    NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
//    NSArray *values = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//    
//    [ResponseUtility getSharedInstance].CategoryDetailsArray = [[NSMutableArray alloc]init];
//    if ([ResponseDictionary isKindOfClass:[NSDictionary class]]) {
//      CategoryDetails *sEvents = [[CategoryDetails alloc]init];
//      sEvents.post_id = [ResponseDictionary valueForKey:@"post_id"];
//      sEvents.venue = [ResponseDictionary valueForKey:@"venue"];
//      NSString *ptitle = [ResponseDictionary valueForKey:@"post_title"];
//      sEvents.post_title = [self base64DecodeString:ptitle];
//      sEvents.start_time = [ResponseDictionary valueForKey:@"start_time"];
//      sEvents.end_time = [ResponseDictionary valueForKey:@"end_time"];
//      sEvents.searchdate = [ResponseDictionary valueForKey:@"date"];
//      NSString *contentStr = [ResponseDictionary valueForKey:@"content"];
//      sEvents.content = [self base64DecodeString:contentStr];
//      NSString *imageStr = [ResponseDictionary valueForKey:@"image"];
//      sEvents.image = [self base64DecodeString:imageStr];
//      sEvents.author = [ResponseDictionary valueForKey:@"author"];
//      sEvents.post_date = [ResponseDictionary valueForKey:@"post_date"];
//      [[ResponseUtility getSharedInstance].CategoryDetailsArray addObject:sEvents];
//    }
//    else if ([ResponseDictionary isKindOfClass:[NSArray class]]){
//      for (NSArray *respo in values){
//        CategoryDetails *sEvents = [[CategoryDetails alloc]init];
//        sEvents.post_id = [respo valueForKey:@"post_id"];
//        sEvents.venue = [respo valueForKey:@"venue"];
//        NSString *ptitle = [respo valueForKey:@"post_title"];
//        sEvents.post_title = [self base64DecodeString:ptitle];
//        sEvents.start_time = [respo valueForKey:@"start_time"];
//        sEvents.end_time = [respo valueForKey:@"end_time"];
//        sEvents.searchdate = [respo valueForKey:@"date"];
//        NSString *contentStr = [respo valueForKey:@"content"];
//        sEvents.content = [self base64DecodeString:contentStr];
//        NSString *imageStr = [respo valueForKey:@"image"];
//        sEvents.image = [self base64DecodeString:imageStr];
//        sEvents.author = [respo valueForKey:@"author"];
//        sEvents.post_date = [respo valueForKey:@"post_date"];
//        [[ResponseUtility getSharedInstance].CategoryDetailsArray addObject:sEvents];
//      }
//    }
//    dispatch_async(dispatch_get_main_queue(), ^{
////      [self hideProcessingScreen];
//      [self.tableVw reloadData];
//    });
//    
//  }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [ResponseUtility getSharedInstance].CategoryDetailsArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{return 80.0;}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *cellIdentifier = @"SearchTableViewCellIdentifier";
  
  SearchTableViewCell *cell = (SearchTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  
  if(cell == nil) {
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SearchTableViewCell" owner:self options:nil];
    cell = [nib objectAtIndex:0];
  }
  CategoryDetails *sObj = [[ResponseUtility getSharedInstance].CategoryDetailsArray objectAtIndex:indexPath.row];
  
  NSString *titleStr = sObj.venue;
  if (titleStr.length>0) {
    cell.titleLbl.text = sObj.venue;
  }else{
    cell.titleLbl.text = @"No title availabel";
  }
  
  NSString *desc = [NSString stringWithFormat:@"%@",sObj.post_title];
  if (desc.length>0) {
    [cell.descriptionLbl setText:desc];}else{cell.descriptionLbl.text = @"No description available";}
  
  NSString *detailDesc = [NSString stringWithFormat:@"%@ %@ %@ @ %@",[self getWeekDayfromStrResponse:sObj.searchdate],[self getMonthfromStrResponse:sObj.searchdate],[self getDatefromStrResponse:sObj.searchdate],sObj.start_time];
  cell.dateTimeLbl.text = detailDesc;
  NSArray *imgUrl = [sObj.image componentsSeparatedByString:@"src=\""];
  NSString *subString;
  if (imgUrl.count>1) {
    subString = [[imgUrl objectAtIndex:1] substringWithRange: NSMakeRange(0, [[imgUrl objectAtIndex:1] rangeOfString: @"\""].location)];
  }
  cell.imgVw.showActivityIndicator = YES;
  cell.imgVw.imageURL = [NSURL URLWithString:subString];
  cell.imgVw.contentMode = UIViewContentModeScaleAspectFit;
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
  NSLog(@"title of cell %ld", (long)indexPath.row);
  CategoryDetails *sObj = [[ResponseUtility getSharedInstance].CategoryDetailsArray objectAtIndex:indexPath.row];
  selectedPostID = sObj.post_id;
  [self performSegueWithIdentifier:@"catDetailtoshowDetailView" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([[segue identifier] isEqualToString:@"catDetailtoshowDetailView"])
  {
    DetailViewController *vc = [segue destinationViewController];
    vc.postId = selectedPostID;
  }
  
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
  str = [str substringToIndex:10];
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



@end
