//
//  StreamViewController.m
//  Totally Barabados
//
//  Created by Sudarshan on 6/21/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

#import "StreamViewController.h"
#import "SWRevealViewController.h"
#import "ResponseUtility.h"
#import "RequestUtility.h"
#import "StreamTableViewCell.h"
#import "DetailViewController.h"

@interface StreamViewController (){
  NSString *selectedPostID;
  NSString *currentSetDate;
}
@property (strong,nonatomic) NSArray *content;
@end

@implementation StreamViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationController.navigationBarHidden = YES;
//  self.title = @"Stream";
  self.title = @"TOTALLY BARBADOS";
//  [self getStreamData:[self getCurrentDate] andendDate:[self getEndDate]];
  SWRevealViewController *revealViewController = self.revealViewController;
  if ( revealViewController )
  {
    [self.sidebarButton setTarget: self.revealViewController];
    [self.sidebarButton setAction: @selector( revealToggle: )];
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
  }
  self.content = @[ @"Monday", @"Tuesday", @"Wednesday",@"Thursday",@"Friday",@"Saturday",@"Sunday", @"Tuesday", @"Wednesday",@"Thursday",@"Friday",@"Saturday",@"Sunday", @"Tuesday", @"Wednesday",@"Thursday",@"Friday",@"Saturday",@"Sunday"];
}

-(void)viewWillAppear:(BOOL)animated{
  currentSetDate = [self getCurrentDate];
  [self getStreamData:[self getCurrentDate] andendDate:[self getEndDate:currentSetDate]];
  [self setDateText];
  
}

-(void)setDateText{
//  NSString *dateText = [NSString stringWithFormat:@"%@\n%@\n%@\n%@",[self getMonthToDisplayfromStrResponse:currentSetDate],[self getWeekDayfromStrResponse:currentSetDate],[self getDateToDisplayfromStrResponse:currentSetDate],[self getYearToDisplayfromStrResponse:currentSetDate]];
//  self.dateLabel.text = dateText;
  self.dateLbl.text = currentSetDate;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [ResponseUtility getSharedInstance].StreamArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{return 270.0;}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *cellIdentifier = @"StreamTableViewCellIdentifier";
  
  StreamTableViewCell *cell = (StreamTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  
  if(cell == nil) {
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"StreamTableViewCell" owner:self options:nil];
    cell = [nib objectAtIndex:0];
  }
  Stream *streamObj = [[ResponseUtility getSharedInstance].StreamArray objectAtIndex:indexPath.row];
  NSString *titleText = [NSString stringWithFormat:@"%@",streamObj.post_title];
    NSString *dateTimeText = [NSString stringWithFormat:@"%@ %@ @ %@ %@ %@",[self getMonthfromStrResponse:streamObj.stream_date],[self getDatefromStrResponse:streamObj.stream_date],streamObj.start_time,streamObj.end_time,streamObj.venue];
  cell.titleLbl.text = titleText;
  cell.dateTimeLbl.text = dateTimeText;
  cell.dateTimeLbl.backgroundColor = [UIColor blackColor];
    cell.titleLbl.backgroundColor = [UIColor blackColor];
  cell.backgroundColor = [UIColor blackColor];
  NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[streamObj.content dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
  cell.descriptionLabel.attributedText = attrStr;
    cell.descriptionLabel.textColor = [UIColor whiteColor];
  cell.descriptionLabel.backgroundColor = [UIColor blackColor];
  
  NSArray *imgUrl = [streamObj.image componentsSeparatedByString:@"\""];
  NSString *url;
  if (imgUrl.count>1) {
    url = [imgUrl objectAtIndex:1];
  }
  cell.imgView.showActivityIndicator = YES;
  cell.imgView.imageURL = [NSURL URLWithString:url];
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
  NSLog(@"title of cell %ld", (long)indexPath.row);
  Stream *streamObj = [[ResponseUtility getSharedInstance].StreamArray objectAtIndex:indexPath.row];
  selectedPostID = streamObj.post_id;
    [self performSegueWithIdentifier:@"showDetailView" sender:nil];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

-(void)getStreamData:(NSString*)currentDate andendDate:(NSString*)endDate{
  
  [self addProccessingScreenWithText:@"Please wait.."];
  RequestUtility *utility = [RequestUtility sharedRequestUtility];
  NSString *url = @"http://developdreamz.com.md-70.webhostbox.net/barbados/stream.php";
  NSDictionary *params = @{@"current_date":currentDate,@"end_date":endDate};
  [utility doPostRequestfor:url withParameters:params onComplete:^(bool status, NSDictionary *responseDictionary){
    if (status) {
      NSLog(@"response:%@",responseDictionary);
      [self parseStreamInfoResponse:responseDictionary];
    }else{
      [self hideProcessingScreen];
    }
  }];
}

-(void)parseStreamInfoResponse:(NSDictionary*)ResponseDictionary{
  if (ResponseDictionary) {
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:ResponseDictionary options:0 error:&err];
    NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *values = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    [ResponseUtility getSharedInstance].StreamArray = [[NSMutableArray alloc]init];
    if ([ResponseDictionary isKindOfClass:[NSDictionary class]]) {
      Stream *streamObj = [[Stream alloc]init];
      streamObj.post_id = [ResponseDictionary valueForKey:@"post_id"];
      streamObj.venue = [ResponseDictionary valueForKey:@"venue"];
      streamObj.allday = [ResponseDictionary valueForKey:@"allday"];
      NSString *ptitle = [ResponseDictionary valueForKey:@"post_title"];
      streamObj.post_title = [self base64DecodeString:ptitle];
      streamObj.start_time = [ResponseDictionary valueForKey:@"start_time"];
      streamObj.end_time = [ResponseDictionary valueForKey:@"end_time"];
      streamObj.stream_date = [ResponseDictionary valueForKey:@"date"];
      NSString *img = [ResponseDictionary valueForKey:@"image"];
      streamObj.image = [self base64DecodeString:img];
      NSString *contentStr = [ResponseDictionary valueForKey:@"content"];
      streamObj.content = [self base64DecodeString:contentStr];
      
      [[ResponseUtility getSharedInstance].StreamArray addObject:streamObj];
    }
    else if ([ResponseDictionary isKindOfClass:[NSArray class]]){
      for (NSArray *respo in values){
        Stream *streamObj = [[Stream alloc]init];
        streamObj.post_id = [respo valueForKey:@"post_id"];
        streamObj.venue = [respo valueForKey:@"venue"];
        streamObj.allday = [respo valueForKey:@"allday"];
        NSString *ptitle = [respo valueForKey:@"post_title"];
        streamObj.post_title = [self base64DecodeString:ptitle];
        streamObj.start_time = [respo valueForKey:@"start_time"];
        streamObj.end_time = [respo valueForKey:@"end_time"];
        streamObj.stream_date = [respo valueForKey:@"date"];
        NSString *img = [respo valueForKey:@"image"];
        streamObj.image = [self base64DecodeString:img];
        NSString *contentStr = [respo valueForKey:@"content"];
        streamObj.content = [self base64DecodeString:contentStr];
        [[ResponseUtility getSharedInstance].StreamArray addObject:streamObj];
      }
    }
    dispatch_async(dispatch_get_main_queue(), ^{
      [self hideProcessingScreen];
      [self.tableVw reloadData];
    });
    
  }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([[segue identifier] isEqualToString:@"showDetailView"])
  {
    DetailViewController *vc = [segue destinationViewController];
    vc.postId = selectedPostID;
  }
}

- (IBAction)nextDateBtnClicked:(id)sender{
  currentSetDate = [self getNextDate:currentSetDate];
  [self setDateText];
  [self getStreamData:currentSetDate andendDate:[self getEndDate:currentSetDate]];
}

- (IBAction)previousDateBtnClicked:(id)sender{
  currentSetDate = [self getPreviousDate:currentSetDate];
  [self setDateText];
  [self getStreamData:currentSetDate andendDate:[self getEndDate:currentSetDate]];
}

@end
