//
//  AgendaViewController.m
//  Totally Barabados
//
//  Created by Sudarshan on 6/21/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

#import "AgendaViewController.h"
#import "SWRevealViewController.h"
#import "AgendaTableViewCell.h"
#import "ResponseUtility.h"
#import "RequestUtility.h"
#import "DetailViewController.h"
@interface AgendaViewController (){
  NSString *selectedPostID;
  NSString *currentSetDate;
}

@end

@implementation AgendaViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.navigationController.navigationBarHidden = YES;
//  self.title = @"Agenda";
  self.title = @"TOTALLY BARBADOS";
  SWRevealViewController *revealViewController = self.revealViewController;
  if ( revealViewController )
  {
    [self.sidebarButton setTarget: self.revealViewController];
    [self.sidebarButton setAction: @selector( revealToggle: )];
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
  }
//  self.dateLabel.text = [NSString stringWithFormat:@"TUE \n 28 \n June \n 2016"];
  
}

-(void)viewWillAppear:(BOOL)animated{
  currentSetDate = [self getCurrentDate];
  [self getAgendaData:[self getCurrentDate] andendDate:[self getEndDate:currentSetDate]];
  [self setDateText];
}

-(void)setDateText{
  NSString *dateText = [NSString stringWithFormat:@"%@\n%@\n%@\n%@",[self getMonthToDisplayfromStrResponse:currentSetDate],[self getWeekDayfromStrResponse:currentSetDate],[self getDateToDisplayfromStrResponse:currentSetDate],[self getYearToDisplayfromStrResponse:currentSetDate]];
  self.dateLabel.text = dateText;
  self.dateLbl.text = currentSetDate;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [ResponseUtility getSharedInstance].AgendaArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{return 80.0;}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *cellIdentifier = @"AgendaTableViewCellIdentifier";
  
  AgendaTableViewCell *cell = (AgendaTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  
  if(cell == nil) {
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AgendaTableViewCell" owner:self options:nil];
    cell = [nib objectAtIndex:0];
  }
  Agenda *agenda = [[ResponseUtility getSharedInstance].AgendaArray objectAtIndex:indexPath.row];
  NSString *desc = [NSString stringWithFormat:@"%@ @%@",agenda.post_title,agenda.venue];
  [cell.descriptionLbl setText:desc];
  NSString *detailDesc = [NSString stringWithFormat:@"%@ %@ %@ - %@",[self getMonthfromStrResponse:agenda.agenda_date],[self getDatefromStrResponse:agenda.agenda_date],agenda.start_time,agenda.end_time];
  cell.dateTimeLbl.text = detailDesc;
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
  NSLog(@"title of cell %ld", (long)indexPath.row);
  Agenda *agenda = [[ResponseUtility getSharedInstance].AgendaArray objectAtIndex:indexPath.row];
  selectedPostID = agenda.post_id;
  [self performSegueWithIdentifier:@"showDetailView" sender:nil];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

-(void)getAgendaData:(NSString*)currentDate andendDate:(NSString*)endDate{
  
  [self addProccessingScreenWithText:@"Please wait.."];
  RequestUtility *utility = [RequestUtility sharedRequestUtility];
  NSString *url = @"http://developdreamz.com.md-70.webhostbox.net/barbados/agenda.php";
  NSDictionary *params = @{@"current_date":currentDate,@"end_date":endDate};
  [utility doPostRequestfor:url withParameters:params onComplete:^(bool status, NSDictionary *responseDictionary){
    if (status) {
      NSLog(@"response:%@",responseDictionary);
      [self parseAgendaInfoResponse:responseDictionary];
    }else{
      [self hideProcessingScreen];
    }
  }];
}

-(void)parseAgendaInfoResponse:(NSDictionary*)ResponseDictionary{
  if (ResponseDictionary) {
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:ResponseDictionary options:0 error:&err];
    NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *values = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    [ResponseUtility getSharedInstance].AgendaArray = [[NSMutableArray alloc]init];
    if ([ResponseDictionary isKindOfClass:[NSDictionary class]]) {
      Agenda *agenda = [[Agenda alloc]init];
      agenda.allday = [ResponseDictionary valueForKey:@"allday"];
      agenda.agenda_date = [ResponseDictionary valueForKey:@"date"];
      agenda.end_time = [ResponseDictionary valueForKey:@"end_time"];
      agenda.post_date = [ResponseDictionary valueForKey:@"post_date"];
      agenda.post_id = [ResponseDictionary valueForKey:@"post_id"];
      NSString *ptitle = [ResponseDictionary valueForKey:@"post_title"];
      agenda.post_title = [self base64DecodeString:ptitle];
      agenda.start_time = [ResponseDictionary valueForKey:@"start_time"];
      agenda.venue = [ResponseDictionary valueForKey:@"venue"];
      
      [[ResponseUtility getSharedInstance].AgendaArray addObject:agenda];
    }
    else if ([ResponseDictionary isKindOfClass:[NSArray class]]){
      for (NSArray *respo in values){
        Agenda *agenda = [[Agenda alloc]init];
        agenda.allday = [respo valueForKey:@"allday"];
        agenda.agenda_date = [respo valueForKey:@"date"];
        agenda.end_time = [respo valueForKey:@"end_time"];
        agenda.post_date = [respo valueForKey:@"post_date"];
        agenda.post_id = [respo valueForKey:@"post_id"];
        NSString *ptitle = [respo valueForKey:@"post_title"];
        agenda.post_title = [self base64DecodeString:ptitle];
        agenda.start_time = [respo valueForKey:@"start_time"];
        agenda.venue = [respo valueForKey:@"venue"];
        [[ResponseUtility getSharedInstance].AgendaArray addObject:agenda];
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
  [self getAgendaData:currentSetDate andendDate:[self getEndDate:currentSetDate]];
}
- (IBAction)previousDateBtnClicked:(id)sender{
  currentSetDate = [self getPreviousDate:currentSetDate];
  [self setDateText];
  [self getAgendaData:currentSetDate andendDate:[self getEndDate:currentSetDate]];
}


@end
