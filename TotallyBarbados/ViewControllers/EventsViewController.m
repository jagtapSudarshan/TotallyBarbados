//
//  EventsViewController.m
//  Totally Barabados
//
//  Created by Sudarshan on 6/21/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

#import "EventsViewController.h"
#import "SWRevealViewController.h"
#import "EventsTableViewCell.h"
#import "ResponseUtility.h"
#import "RequestUtility.h"
#import "DetailViewController.h"
@interface EventsViewController ()<UITableViewDataSource,UITableViewDelegate>{
  NSString *selectedPostID;
  NSString *currentSetDate;
}
@end

@implementation EventsViewController
- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationController.navigationBarHidden = YES;
//  self.title = @"Events";
  self.title = @"TOTALLY BARBADOS";
  self.view.backgroundColor = [UIColor blueColor];
//  NSString *datestr = [NSString stringWithFormat:@"%@ %@ %@ %@",[self getWeekDayfromStrResponse:[self getCurrentDate]],[self getDatefromStrResponse:[]]]
  self.dateLabel.text = [NSString stringWithFormat:@"TUE 28 June 2016"];
  
  
  SWRevealViewController *revealViewController = self.revealViewController;
  if ( revealViewController )
  {
    [self.sidebarButton setTarget: self.revealViewController];
    [self.sidebarButton setAction: @selector( revealToggle: )];
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
  }
  
}

-(void)viewWillAppear:(BOOL)animated{
  currentSetDate = [self getCurrentDate];
  [self getEventsData:[self getCurrentDate] andendDate:[self getEndDate:currentSetDate]];
  [self setDateText];
  
}

-(void)setDateText{
  NSString *dateText = [NSString stringWithFormat:@"%@ %@ %@ %@",[self getMonthToDisplayfromStrResponse:currentSetDate],[self getWeekDayfromStrResponse:currentSetDate],[self getDateToDisplayfromStrResponse:currentSetDate],[self getYearToDisplayfromStrResponse:currentSetDate]];
  self.dateLabel.text = dateText;
  self.dateLbl.text = currentSetDate;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [ResponseUtility getSharedInstance].BarbadosArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{return 253.0;}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *cellIdentifier = @"EventsTableViewCellIdentifier";
  
  EventsTableViewCell *cell = (EventsTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  
  if(cell == nil) {
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"EventsTableViewCell" owner:self options:nil];
    cell = [nib objectAtIndex:0];
  }
  Barbados *barbados = [[ResponseUtility getSharedInstance].BarbadosArray objectAtIndex:indexPath.row];
  NSString *titleDesc = [NSString stringWithFormat:@"%@",barbados.post_title];
  [cell.titleLbl setText:titleDesc];
  NSString *detailDesc = [NSString stringWithFormat:@"%@ %@ @ %@ - %@ @ %@",[self getMonthfromStrResponse:barbados.barbados_date],[self getDatefromStrResponse:barbados.barbados_date],barbados.start_time,barbados.end_time,barbados.venue];
  cell.dateTimeDescriptionLbl.text = detailDesc;

//  [cell.imgVw setImage:[UIImage imageNamed:@"online"]];
  
  NSArray *imgUrl = [barbados.image componentsSeparatedByString:@"src=\""];
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
  Barbados *barbados = [[ResponseUtility getSharedInstance].BarbadosArray objectAtIndex:indexPath.row];
  selectedPostID = barbados.post_id;
  [self performSegueWithIdentifier:@"showDetailView" sender:nil];
}
- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

-(void)getEventsData:(NSString*)currentDate andendDate:(NSString*)endDate{
  
  [self addProccessingScreenWithText:@"Please wait.."];
  RequestUtility *utility = [RequestUtility sharedRequestUtility];
  NSString *url = @"http://developdreamz.com.md-70.webhostbox.net/barbados/barbados.php";
  NSDictionary *params = @{@"current_date":currentDate,@"end_date":endDate};
  [utility doPostRequestfor:url withParameters:params onComplete:^(bool status, NSDictionary *responseDictionary){
    if (status) {
      NSLog(@"response:%@",responseDictionary);
      [self parseEventsInfoResponse:responseDictionary];
    }else{
      [self hideProcessingScreen];
    }
  }];
}

-(void)parseEventsInfoResponse:(NSDictionary*)ResponseDictionary{
  if (ResponseDictionary) {
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:ResponseDictionary options:0 error:&err];
    NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *values = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    [ResponseUtility getSharedInstance].BarbadosArray = [[NSMutableArray alloc]init];
    if ([ResponseDictionary isKindOfClass:[NSDictionary class]]) {
      Barbados *barbados = [[Barbados alloc]init];
      barbados.post_id = [ResponseDictionary valueForKey:@"post_id"];
      barbados.venue = [ResponseDictionary valueForKey:@"venue"];
      NSString *phoneNum = [ResponseDictionary valueForKey:@"contact_phone"];
      barbados.contact_phone = [self base64DecodeString:phoneNum];
      NSString *title = [ResponseDictionary valueForKey:@"post_title"];
      barbados.post_title = [self base64DecodeString:title];
      barbados.start_time = [ResponseDictionary valueForKey:@"start_time"];
      barbados.end_time = [ResponseDictionary valueForKey:@"end_time"];
      barbados.barbados_date = [ResponseDictionary valueForKey:@"date"];
      barbados.lati = [ResponseDictionary valueForKey:@"latitude"];
      barbados.longi = [ResponseDictionary valueForKey:@"longitude"];
      NSString *imgStr = [ResponseDictionary valueForKey:@"image"];
      barbados.image = [self base64DecodeString:imgStr];
      NSString *contentStr = [ResponseDictionary valueForKey:@"content"];
      barbados.content = [self base64DecodeString:contentStr];
      
      [[ResponseUtility getSharedInstance].BarbadosArray addObject:barbados];
    }
    else if ([ResponseDictionary isKindOfClass:[NSArray class]]){
      for (NSArray *respo in values){
        Barbados *barbados = [[Barbados alloc]init];
        barbados.post_id = [respo valueForKey:@"post_id"];
        barbados.venue = [respo valueForKey:@"venue"];
        NSString *phoneNum = [respo valueForKey:@"contact_phone"];
        barbados.contact_phone = [self base64DecodeString:phoneNum];
        NSString *title = [respo valueForKey:@"post_title"];
        barbados.post_title = [self base64DecodeString:title];
        barbados.start_time = [respo valueForKey:@"start_time"];
        barbados.end_time = [respo valueForKey:@"end_time"];
        barbados.barbados_date = [respo valueForKey:@"date"];
        barbados.lati = [respo valueForKey:@"latitude"];
        barbados.longi = [respo valueForKey:@"longitude"];
        NSString *imgStr = [respo valueForKey:@"image"];
        barbados.image = [self base64DecodeString:imgStr];
        NSString *contentStr = [respo valueForKey:@"content"];
        barbados.content = [self base64DecodeString:contentStr];
        [[ResponseUtility getSharedInstance].BarbadosArray addObject:barbados];
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
  [self getEventsData:currentSetDate andendDate:[self getEndDate:currentSetDate]];
}

- (IBAction)previousDateBtnClicked:(id)sender{
  currentSetDate = [self getPreviousDate:currentSetDate];
  [self setDateText];
  [self getEventsData:currentSetDate andendDate:[self getEndDate:currentSetDate]];
}


@end
