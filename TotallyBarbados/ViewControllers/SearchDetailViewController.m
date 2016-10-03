//
//  SearchDetailViewController.m
//  TotallyBarbados
//
//  Created by Sudarshan on 6/27/16.
//  Copyright © 2016 Uniken. All rights reserved.
//

#import "SearchDetailViewController.h"
#import "ResponseUtility.h"
#import "RequestUtility.h"
#import "SearchTableViewCell.h"
#import "DetailViewController.h"
@interface SearchDetailViewController ()<UITableViewDataSource,UITableViewDelegate>{
  NSString *selectedPostID;
}

@end

@implementation SearchDetailViewController
@synthesize serachText;
- (void)viewDidLoad {
    [super viewDidLoad];
  self.title = @"TOTALLY BARBADOS";
  self.navigationController.navigationBarHidden = YES;
  [self getSearchDetailsData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [ResponseUtility getSharedInstance].SearchArray.count;
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
  SearchEvents *sObj = [[ResponseUtility getSharedInstance].SearchArray objectAtIndex:indexPath.row];
  
  NSString *titleStr = sObj.venue;
  if (titleStr.length>0) {
    cell.titleLbl.text = sObj.venue;
  }else{
    cell.titleLbl.text = @"No title availabel";
  }
  
  NSString *desc = [NSString stringWithFormat:@"%@",sObj.post_title];
  if (desc.length>0) {
    [cell.descriptionLbl setText:desc];}else{cell.descriptionLbl.text = @"No description available";}
  
  NSString *detailDesc = [NSString stringWithFormat:@"%@ %@ %@ - %@",[self getMonthfromStrResponse:sObj.searchdate],[self getDatefromStrResponse:sObj.searchdate],sObj.start_time,sObj.end_time];
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
  SearchEvents *sObj = [[ResponseUtility getSharedInstance].SearchArray objectAtIndex:indexPath.row];
  selectedPostID = sObj.post_id;
  [self performSegueWithIdentifier:@"showDetailView" sender:nil];
}

-(void)getSearchDetailsData{
  
  [self addProccessingScreenWithText:@"Please wait.."];
  RequestUtility *utility = [RequestUtility sharedRequestUtility];
  NSString *url = @"http://developdreamz.com.md-70.webhostbox.net/barbados/search.php";
  NSDictionary *params = @{@"search_term":serachText};
  [utility doPostRequestfor:url withParameters:params onComplete:^(bool status, NSDictionary *responseDictionary){
    if (status) {
      NSLog(@"response:%@",responseDictionary);
      [self parseSearchDetailsInfoResponse:responseDictionary];
    }else{
      [self hideProcessingScreen];
    }
  }];
}

-(void)parseSearchDetailsInfoResponse:(NSDictionary*)ResponseDictionary{
  if (ResponseDictionary) {
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:ResponseDictionary options:0 error:&err];
    NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *values = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    [ResponseUtility getSharedInstance].SearchArray = [[NSMutableArray alloc]init];
    if ([ResponseDictionary isKindOfClass:[NSDictionary class]]) {
      SearchEvents *sEvents = [[SearchEvents alloc]init];
      sEvents.post_id = [ResponseDictionary valueForKey:@"post_id"];
      sEvents.venue = [ResponseDictionary valueForKey:@"venue"];
      NSString *ptitle = [ResponseDictionary valueForKey:@"post_title"];
      sEvents.post_title = [self base64DecodeString:ptitle];
      sEvents.start_time = [ResponseDictionary valueForKey:@"start_time"];
      sEvents.end_time = [ResponseDictionary valueForKey:@"end_time"];
      sEvents.searchdate = [ResponseDictionary valueForKey:@"date"];
      NSString *contentStr = [ResponseDictionary valueForKey:@"content"];
      sEvents.content = [self base64DecodeString:contentStr];
      NSString *imageStr = [ResponseDictionary valueForKey:@"image"];
      sEvents.image = [self base64DecodeString:imageStr];
      sEvents.author = [ResponseDictionary valueForKey:@"author"];
      sEvents.post_date = [ResponseDictionary valueForKey:@"post_date"];
      [[ResponseUtility getSharedInstance].SearchArray addObject:sEvents];
    }
    else if ([ResponseDictionary isKindOfClass:[NSArray class]]){
      for (NSArray *respo in values){
        SearchEvents *sEvents = [[SearchEvents alloc]init];
        sEvents.post_id = [respo valueForKey:@"post_id"];
        sEvents.venue = [respo valueForKey:@"venue"];
        NSString *ptitle = [respo valueForKey:@"post_title"];
        sEvents.post_title = [self base64DecodeString:ptitle];
        sEvents.start_time = [respo valueForKey:@"start_time"];
        sEvents.end_time = [respo valueForKey:@"end_time"];
        sEvents.searchdate = [respo valueForKey:@"date"];
        NSString *contentStr = [respo valueForKey:@"content"];
        sEvents.content = [self base64DecodeString:contentStr];
        NSString *imageStr = [respo valueForKey:@"image"];
        sEvents.image = [self base64DecodeString:imageStr];
        sEvents.author = [respo valueForKey:@"author"];
        sEvents.post_date = [respo valueForKey:@"post_date"];
        [[ResponseUtility getSharedInstance].SearchArray addObject:sEvents];
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



@end
