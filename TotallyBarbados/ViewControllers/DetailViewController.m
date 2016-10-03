//
//  DetailViewController.m
//  TotallyBarbados
//
//  Created by Sudarshan on 6/27/16.
//  Copyright © 2016 Uniken. All rights reserved.
//

#import "DetailViewController.h"
#import "RequestUtility.h"
#import "ResponseUtility.h"

@interface DetailViewController (){
  ViewDetails *vwDetailsObj;
}

@end

@implementation DetailViewController
@synthesize postId;
- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"TOTALLY BARBADOS";
  self.navigationController.navigationBarHidden = YES;
  vwDetailsObj = [[ViewDetails alloc]init];
  [self getViewDetailsData];
  // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

-(void)getViewDetailsData{
  
  [self addProccessingScreenWithText:@"Please wait.."];
  RequestUtility *utility = [RequestUtility sharedRequestUtility];
  NSString *url = @"http://developdreamz.com.md-70.webhostbox.net/barbados/post_details.php";
  NSDictionary *params = @{@"post_id":postId};
  [utility doPostRequestfor:url withParameters:params onComplete:^(bool status, NSDictionary *responseDictionary){
    if (status) {
      NSLog(@"response:%@",responseDictionary);
      [self parseViewDetailsInfoResponse:responseDictionary];
    }else{
      [self hideProcessingScreen];
    }
  }];
}

-(void)parseViewDetailsInfoResponse:(NSDictionary*)ResponseDictionary{
  if (ResponseDictionary) {
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:ResponseDictionary options:0 error:&err];
    NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *values = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    for (NSArray *respo in values){
    vwDetailsObj.venue = [respo valueForKey:@"venue"];
    vwDetailsObj.allday = [respo valueForKey:@"allday"];
    NSString *ptitle = [respo valueForKey:@"post_title"];
    vwDetailsObj.post_title = [self base64DecodeString:ptitle];
    vwDetailsObj.start_time = [respo valueForKey:@"start_time"];
    vwDetailsObj.end_time = [respo valueForKey:@"end_time"];
    vwDetailsObj.view_date = [respo valueForKey:@"date"];
    NSString *img = [respo valueForKey:@"image"];
    vwDetailsObj.image = [self base64DecodeString:img];
    NSString *contentStr = [respo valueForKey:@"content"];
    vwDetailsObj.content = [self base64DecodeString:contentStr];
    NSString *phoneStr = [respo valueForKey:@"contact_phone"];
    vwDetailsObj.contact_phone = [self base64DecodeString:phoneStr];
    vwDetailsObj.lati = [respo valueForKey:@"latitude"];
    vwDetailsObj.longi = [respo valueForKey:@"longitude"];
    vwDetailsObj.contact_email = [respo valueForKey:@"contact_email"];
    vwDetailsObj.city = [respo valueForKey:@"city"];
    vwDetailsObj.address = [respo valueForKey:@"address"];
    vwDetailsObj.country = [respo valueForKey:@"country"];
    vwDetailsObj.post_date = [respo valueForKey:@"post_date"];
    vwDetailsObj.post_author = [respo valueForKey:@"post_author"];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
      [self hideProcessingScreen];
      [self addLocationToMap];
      [self displayData];

    });
  }else{
    //show alert.
  }
}

-(void)displayData{

  NSString *dateTimeText = [NSString stringWithFormat:@"%@ %@ %@ @ %@-%@",[self getMonthfromStrResponse:vwDetailsObj.view_date],[self getDatefromStrResponse:vwDetailsObj.view_date],[self getWeekDayfromStrResponse:vwDetailsObj.view_date],vwDetailsObj.start_time,vwDetailsObj.end_time];
  self.dateTimeLbl.text = dateTimeText;
  NSString *venueContStr = [NSString stringWithFormat:@" Venue - %@ \n Contact - %@",vwDetailsObj.venue,vwDetailsObj.contact_phone];
  self.venueLbl.text = venueContStr;
  NSString *postTitleStr = [NSString stringWithFormat:@"%@",vwDetailsObj.post_title];
  self.titleLbl.text = postTitleStr;
  self.mainTitleLbl.text = postTitleStr;
  NSArray *imgUrl = [vwDetailsObj.image componentsSeparatedByString:@"src=\""];
  NSString *subString;
  if (imgUrl.count>1) {
    subString = [[imgUrl objectAtIndex:1] substringWithRange: NSMakeRange(0, [[imgUrl objectAtIndex:1] rangeOfString: @"\""].location)];
  }
  self.imgView.showActivityIndicator = YES;
  self.imgView.imageURL = [NSURL URLWithString:subString];
  
}

-(void)addLocationToMap{
  MKCoordinateRegion region;
  CLLocation *locObj = [[CLLocation alloc] initWithCoordinate:CLLocationCoordinate2DMake([vwDetailsObj.lati doubleValue], [vwDetailsObj.longi doubleValue])
                                                     altitude:0
                                           horizontalAccuracy:0
                                             verticalAccuracy:0
                                                    timestamp:[NSDate date]];
  region.center = locObj.coordinate;
  MKCoordinateSpan span;
  span.latitudeDelta  = 1; // values for zoom
  span.longitudeDelta = 1;
  region.span = span;
  [self.mapVw setRegion:region animated:YES];
}


@end
