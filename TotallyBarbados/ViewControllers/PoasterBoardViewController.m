//
//  PoasterBoardViewController.m
//  Totally Barabados
//
//  Created by Sudarshan on 6/21/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

#import "PoasterBoardViewController.h"
#import "SWRevealViewController.h"
#import "PoasterBoardCollectionViewCell.h"
#import "RequestUtility.h"
#import "ResponseUtility.h"
#import "DetailViewController.h"
@interface PoasterBoardViewController (){
  NSString *selectedPostID;
  NSString *currentSetDate;
}

@end

@implementation PoasterBoardViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationController.navigationBarHidden = YES;
//  self.title = @"PoasterBoard";
  self.title = @"TOTALLY BARBADOS";
//  [self getPosterBoardData:[self getCurrentDate] andendDate:[self getEndDate]];
  SWRevealViewController *revealViewController = self.revealViewController;
  if ( revealViewController )
  {
    [self.sidebarButton setTarget: self.revealViewController];
    [self.sidebarButton setAction: @selector( revealToggle: )];
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
  }
  
  UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
  CGFloat width = [UIScreen mainScreen].bounds.size.width;
  if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
  {
    // The device is an iPad running iPhone 3.2 or later.
    flow.itemSize = CGSizeMake(width/5 -10, 312);
  }
  else
  {
    flow.itemSize = CGSizeMake(width/2 -10, 312);
  }
  flow.scrollDirection = UICollectionViewScrollDirectionVertical;
  //  flow.minimumInteritemSpacing = 0;
  //  flow.minimumLineSpacing = 0;
  self.collectionVw.collectionViewLayout = flow;
}

-(void)viewWillAppear:(BOOL)animated{
  currentSetDate = [self getCurrentDate];
  [self getPosterBoardData:[self getCurrentDate] andendDate:[self getEndDate:currentSetDate]];
  [self setDateText];
  
}

-(void)setDateText{
//  NSString *dateText = [NSString stringWithFormat:@"%@\n%@\n%@\n%@",[self getMonthToDisplayfromStrResponse:currentSetDate],[self getWeekDayfromStrResponse:currentSetDate],[self getDateToDisplayfromStrResponse:currentSetDate],[self getYearToDisplayfromStrResponse:currentSetDate]];
//    self.dateLabel.text = dateText;
  self.dateLbl.text = currentSetDate;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return [ResponseUtility getSharedInstance].PosterBoardArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  PoasterBoardCollectionViewCell *vc = nil;
  if (collectionView == self.collectionVw) {
    vc = (PoasterBoardCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"PoasterBoardCellID" forIndexPath:indexPath];
    PosterBoard *pObj = [[ResponseUtility getSharedInstance].PosterBoardArray objectAtIndex:indexPath.row];
    NSString *titleText = [NSString stringWithFormat:@"%@ @ %@",pObj.post_title,pObj.venue];
    vc.titleLabel.text = titleText;
    NSString *dateTimeText = [NSString stringWithFormat:@"%@ %@ @ %@-%@",[self getMonthfromStrResponse:pObj.posterBoard_date],[self getDatefromStrResponse:pObj.posterBoard_date],pObj.start_time,pObj.end_time];
     vc.semiDateLabel.text = dateTimeText;
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[pObj.content dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    vc.descriptionLabel.attributedText = attrStr;
    
    NSString *dStr = [pObj.posterBoard_date substringToIndex:10];
    NSString *dateTextStr = [NSString stringWithFormat:@"%@\n%@\n%@\n%@",[self getMonthToDisplayfromStrResponse:dStr],[self getDateToDisplayfromStrResponse:dStr],[self getWeekDayfromStrResponse:dStr],[self getYearToDisplayfromStrResponse:dStr]];
    vc.dateLabel.text = dateTextStr;
  
//    vc.descriptionLabel.textColor = [UIColor whiteColor];
//    vc.descriptionLabel.backgroundColor = [UIColor blackColor];
    NSArray *imgUrl = [pObj.image componentsSeparatedByString:@"src=\""];
    NSString *subString;
    if (imgUrl.count>1) {
      subString = [[imgUrl objectAtIndex:1] substringWithRange: NSMakeRange(0, [[imgUrl objectAtIndex:1] rangeOfString: @"\""].location)];
    }
    vc.imgView.showActivityIndicator = YES;
    vc.imgView.imageURL = [NSURL URLWithString:subString];
    return vc;
    
    
  }else{
    return nil;
  }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
  
  PosterBoard *pObj = [[ResponseUtility getSharedInstance].PosterBoardArray objectAtIndex:indexPath.row];
  selectedPostID = pObj.post_id;
  [self performSegueWithIdentifier:@"showDetailView" sender:nil];
}
- (UIEdgeInsets)collectionView:(UICollectionView *) collectionView
                        layout:(UICollectionViewLayout *) collectionViewLayout
        insetForSectionAtIndex:(NSInteger) section {
  
  return UIEdgeInsetsMake(05, 07, 10, 7); // top, left, bottom, right
}

- (CGFloat)collectionView:(UICollectionView *) collectionView
                   layout:(UICollectionViewLayout *) collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger) section {
  return 5.0;
}

-(void)getPosterBoardData:(NSString*)currentDate andendDate:(NSString*)endDate{
  
  [self addProccessingScreenWithText:@"Please wait.."];
  RequestUtility *utility = [RequestUtility sharedRequestUtility];
  NSString *url = @"http://developdreamz.com.md-70.webhostbox.net/barbados/posterboard.php";
  NSDictionary *params = @{@"current_date":currentDate,@"end_date":endDate};
  [utility doPostRequestfor:url withParameters:params onComplete:^(bool status, NSDictionary *responseDictionary){
    if (status) {
      NSLog(@"response:%@",responseDictionary);
      [self parsePosterBoardInfoResponse:responseDictionary];
    }else{
      [self hideProcessingScreen];
    }
  }];
}

-(void)parsePosterBoardInfoResponse:(NSDictionary*)ResponseDictionary{
  if (ResponseDictionary) {
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:ResponseDictionary options:0 error:&err];
    NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *values = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    [ResponseUtility getSharedInstance].PosterBoardArray = [[NSMutableArray alloc]init];
    if ([ResponseDictionary isKindOfClass:[NSDictionary class]]) {
      PosterBoard *pBoard = [[PosterBoard alloc]init];
      pBoard.post_id = [ResponseDictionary valueForKey:@"post_id"];
      pBoard.venue = [ResponseDictionary valueForKey:@"venue"];
      NSString *ptitle = [ResponseDictionary valueForKey:@"post_title"];
      pBoard.post_title = [self base64DecodeString:ptitle];
      pBoard.start_time = [ResponseDictionary valueForKey:@"start_time"];
      pBoard.end_time = [ResponseDictionary valueForKey:@"end_time"];
      pBoard.posterBoard_date = [ResponseDictionary valueForKey:@"date"];
      NSString *img = [ResponseDictionary valueForKey:@"image"];
      pBoard.image = [self base64DecodeString:img];
      NSString *contentStr = [ResponseDictionary valueForKey:@"content"];
      pBoard.content = [self base64DecodeString:contentStr];
      
      [[ResponseUtility getSharedInstance].PosterBoardArray addObject:pBoard];
    }
    else if ([ResponseDictionary isKindOfClass:[NSArray class]]){
      for (NSArray *respo in values){
        PosterBoard *pBoard = [[PosterBoard alloc]init];
        pBoard.post_id = [respo valueForKey:@"post_id"];
        pBoard.venue = [respo valueForKey:@"venue"];
        NSString *ptitle = [respo valueForKey:@"post_title"];
        pBoard.post_title = [self base64DecodeString:ptitle];
        pBoard.start_time = [respo valueForKey:@"start_time"];
        pBoard.end_time = [respo valueForKey:@"end_time"];
        pBoard.posterBoard_date = [respo valueForKey:@"date"];
        NSString *img = [respo valueForKey:@"image"];
        pBoard.image = [self base64DecodeString:img];
        NSString *contentStr = [respo valueForKey:@"content"];
        pBoard.content = [self base64DecodeString:contentStr];
        [[ResponseUtility getSharedInstance].PosterBoardArray addObject:pBoard];
      }
    }
    dispatch_async(dispatch_get_main_queue(), ^{
      [self hideProcessingScreen];
            [self.collectionVw reloadData];
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
- (IBAction)nextDateBtnClicked:(id)sender {
  currentSetDate = [self getNextDate:currentSetDate];
  [self setDateText];
  [self getPosterBoardData:currentSetDate andendDate:[self getEndDate:currentSetDate]];
}

- (IBAction)previousDateBtnClicked:(id)sender {
  currentSetDate = [self getPreviousDate:currentSetDate];
  [self setDateText];
  [self getPosterBoardData:currentSetDate andendDate:[self getEndDate:currentSetDate]];
}
@end
