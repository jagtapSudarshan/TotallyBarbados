//
//  MainViewController.m
//  SidebarDemo
//
//  Created by Simon Ng on 10/11/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

#import "MainViewController.h"
#import "SWRevealViewController.h"
#import "VerticalCollectionViewCell.h"
#import "HorizontalCollectionViewCell.h"
#import "RequestUtility.h"
#import "ResponseUtility.h"
#import "WebviewViewController.h"
#import "SearchDetailViewController.h"
#import "CategoriesViewController.h"
@interface MainViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
  UICollectionView *_collectionView;
  NSString *webLink;
  NSString *searchString;
  NSString *selectedCId;
}

@end

@implementation MainViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationController.navigationBarHidden = YES;
  self.searchView.layer.cornerRadius = 5.0;
  UIColor *color = [UIColor blackColor];
  self.searchTextfld.attributedPlaceholder =
  [[NSAttributedString alloc]
   initWithString:@"Search events nearby..."
   attributes:@{NSForegroundColorAttributeName:color}];
  self.title = @"TOTALLY BARBADOS";
  
      self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:125/255.0 green:102/255.0 blue:8/255.0 alpha:1];
            self.navigationController.navigationBar.tintColor = [UIColor yellowColor];
            self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
      [[UINavigationBar appearance] setTitleTextAttributes: @{
                                                              NSForegroundColorAttributeName: [UIColor blackColor],
                                                              NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:20.0f]
                                                              }];
  
  SWRevealViewController *revealViewController = self.revealViewController;
  if ( revealViewController )
  {
    [self.sidebarButton setTarget: self.revealViewController];
    [self.sidebarButton setAction: @selector( revealToggle: )];
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
  }
  
  NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Images" ofType:@"plist"];
  NSDictionary *imagePaths = [NSDictionary dictionaryWithContentsOfFile:plistPath];
  
  //remote image URLs
  NSMutableArray *URLs = [NSMutableArray array];
  for (NSString *path in imagePaths[@"Remote"])
  {
    NSURL *URL = [NSURL URLWithString:path];
    if (URL)
    {
      [URLs addObject:URL];
    }
    else
    {
      NSLog(@"'%@' is not a valid URL", path);
    }
  }
  self.imageURLs = URLs;
  
  UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
  flow.itemSize = CGSizeMake(width/3-1, 55);
  flow.scrollDirection = UICollectionViewScrollDirectionVertical;
  //  flow.minimumInteritemSpacing = 0;
  //  flow.minimumLineSpacing = 0;
  self.cvV.collectionViewLayout = flow;
  
  UICollectionViewFlowLayout *flow1 = [[UICollectionViewFlowLayout alloc] init];
  flow1.itemSize = CGSizeMake(188, 183);
  flow1.scrollDirection = UICollectionViewScrollDirectionHorizontal;
  //  flow.minimumInteritemSpacing = 0;
  //  flow.minimumLineSpacing = 0;
  self.collectionViewHorizontal.collectionViewLayout = flow1;
  [self getTrendingCategoriesData];
  [self getTrendingEventsData];

}

-(void)viewWillAppear:(BOOL)animated{
  self.searchBtn.hidden = YES;
[self.searchTextfld addTarget:self action:@selector(checkTextField:) forControlEvents:UIControlEventEditingChanged];
}

- (UIEdgeInsets)collectionView:(UICollectionView *) collectionView
                        layout:(UICollectionViewLayout *) collectionViewLayout
        insetForSectionAtIndex:(NSInteger) section {
  
  return UIEdgeInsetsMake(01, 01, 01, 1); // top, left, bottom, right
}

- (CGFloat)collectionView:(UICollectionView *) collectionView
                   layout:(UICollectionViewLayout *) collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger) section {
  return 1.0;
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

//    return self.imageURLs.count;
  if (collectionView == self.cvV) {
//    return [ResponseUtility getSharedInstance].TrendingCatrgoriesArray.count;
    return 9;
  }else{
     return [ResponseUtility getSharedInstance].TrendingEventsArray.count;
  }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  HorizontalCollectionViewCell *hCell = nil;
  VerticalCollectionViewCell *vc = nil;
  if (collectionView == self.cvV) {
    vc = (VerticalCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"test1" forIndexPath:indexPath];
    //[vc.imgView setImage:[UIImage imageNamed:@"online"]];
   // vc.imgView.image = [UIImage imageNamed:@"Placeholder.png"];
    
    //load the image
//    vc.imgView.showActivityIndicator = YES;
//    vc.imgView.imageURL = self.imageURLs[(NSUInteger)indexPath.row];
    if ([ResponseUtility getSharedInstance ].TrendingCatrgoriesArray.count>0) {
    
    TrendingCategories *tcat = [[ResponseUtility getSharedInstance].TrendingCatrgoriesArray objectAtIndex:indexPath.row];
    vc.Txtlbl.text =tcat.t_name;
    vc.Txtlbl.backgroundColor = [self randomColor];
    }
    
    
    
    return vc;
  }else if (collectionView == self.collectionViewHorizontal){
     hCell = (HorizontalCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"test" forIndexPath:indexPath];
    TrendingEvents *tEvents = [[ResponseUtility getSharedInstance].TrendingEventsArray objectAtIndex:indexPath.row];
    hCell.imgView.showActivityIndicator = YES;
    hCell.imgView.imageURL = [NSURL URLWithString:tEvents.image_url];
    hCell.txtlbl.text = tEvents.title;
    return hCell;
  }else{
  return nil;
  }
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
 
  if (collectionView == self.cvV) {
    TrendingCategories *tcat = [[ResponseUtility getSharedInstance].TrendingCatrgoriesArray objectAtIndex:indexPath.row];
    selectedCId = tcat.t_id;
    [self getDetailCategoriesData];
//   [self performSegueWithIdentifier:@"showCategoriesView" sender:nil];
  }else{
      TrendingEvents *tEvents = [[ResponseUtility getSharedInstance].TrendingEventsArray objectAtIndex:indexPath.row];
      webLink = tEvents.link;
    [self performSegueWithIdentifier:@"showWebView" sender:nil];
  }
}

//showCategoriesView

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (UIColor*) randomColor{
  int r = arc4random() % 255;
  int g = arc4random() % 255;
  int b = arc4random() % 255;
  return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
}

- (void)checkTextField:(id)sender{
  UITextField *textField = (UITextField *)sender;
  NSString *text = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
  if ([text length] > 0) {
    self.searchBtn.hidden = NO; // No cargo-culting please, this color is very ugly...
  } else {
        self.searchBtn.hidden = YES;
    /* Must be done in case the user deletes a key after adding 8 digits,
     or adds a ninth digit */
  }
}

- (IBAction)searchButtonPressed:(id)sender {
  searchString =  self.searchTextfld.text;
  [self performSegueWithIdentifier:@"showSearchDetails" sender:nil];
}
-(void)getTrendingCategoriesData{
   NSDictionary *params = @{@"current_date":[self getCurrentDate],@"end_date":[self getEndDate:[self getCurrentDate]]};
  [self addProccessingScreenWithText:@"Please wait.."];
  RequestUtility *utility = [RequestUtility sharedRequestUtility];
  NSString *url = @"http://developdreamz.com.md-70.webhostbox.net/barbados/home_categories.php";
  [utility doPostRequestfor:url withParameters:params onComplete:^(bool status, NSDictionary *responseDictionary){
    if (status) {
      NSLog(@"response:%@",responseDictionary);
      [self parseTrendingCategoriesInfoResponse:responseDictionary];
    }else{
      [self hideProcessingScreen];
    }
  }];
}

-(void)parseTrendingCategoriesInfoResponse:(NSDictionary*)ResponseDictionary{
  if (ResponseDictionary.count>0) {
//    if (![ResponseDictionary valueForKey:@"error"]) {
   
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:ResponseDictionary options:0 error:&err];
    NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *values = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    [ResponseUtility getSharedInstance].TrendingCatrgoriesArray = [[NSMutableArray alloc]init];
    if ([ResponseDictionary isKindOfClass:[NSDictionary class]]) {
      TrendingCategories *catObj = [[TrendingCategories alloc]init];
      catObj.t_id = [ResponseDictionary valueForKey:@"category_id"];
      catObj.t_name = [ResponseDictionary valueForKey:@"category_name"];
//      catObj.t_icon = [ResponseDictionary valueForKey:@"icon"];
//      catObj.t_slug = [ResponseDictionary valueForKey:@"slug"];
      [[ResponseUtility getSharedInstance].TrendingCatrgoriesArray addObject:catObj];
    }
    else if ([ResponseDictionary isKindOfClass:[NSArray class]]){
      for (NSArray *respo in values){
        TrendingCategories *catObj = [[TrendingCategories alloc]init];
        catObj.t_id = [respo valueForKey:@"category_id"];
        catObj.t_name = [respo valueForKey:@"category_name"];
//        catObj.t_icon = [respo valueForKey:@"icon"];
//        catObj.t_slug = [respo valueForKey:@"slug"];
        [[ResponseUtility getSharedInstance].TrendingCatrgoriesArray addObject:catObj];
      }
    }
    dispatch_async(dispatch_get_main_queue(), ^{
      [self hideProcessingScreen];
      [self.cvV reloadData];
    });
    
//  }
  }
}


-(void)getTrendingEventsData{
  
  [self addProccessingScreenWithText:@"Please wait.."];
  RequestUtility *utility = [RequestUtility sharedRequestUtility];
  NSString *url = @"http://developdreamz.com.md-70.webhostbox.net/barbados/trending_events.php";
  [utility doRequestfor:url withParameters:nil onComplete:^(bool status, NSDictionary *responseDictionary){
    if (status) {
      NSLog(@"response:%@",responseDictionary);
      [self parseTrendingEventsInfoResponse:responseDictionary];
    }else{
      [self hideProcessingScreen];
    }
  }];
}

-(void)parseTrendingEventsInfoResponse:(NSDictionary*)ResponseDictionary{
  if (ResponseDictionary) {
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:ResponseDictionary options:0 error:&err];
    NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *values = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    [ResponseUtility getSharedInstance].TrendingEventsArray = [[NSMutableArray alloc]init];
    if ([ResponseDictionary isKindOfClass:[NSDictionary class]]) {
      TrendingEvents *eventsObj = [[TrendingEvents alloc]init];
      eventsObj.te_id = [ResponseDictionary valueForKey:@"id"];
      NSString *titleStr = [ResponseDictionary valueForKey:@"title"];
      eventsObj.title = [self base64DecodeString:titleStr];
      NSString *image_urlStr = [ResponseDictionary valueForKey:@"image_url"];
      eventsObj.image_url = [self base64DecodeString:image_urlStr];
      eventsObj.link = [ResponseDictionary valueForKey:@"link"];
      [[ResponseUtility getSharedInstance].TrendingEventsArray addObject:eventsObj];
    }
    else if ([ResponseDictionary isKindOfClass:[NSArray class]]){
      for (NSArray *respo in values){
        TrendingEvents *eventsObj = [[TrendingEvents alloc]init];
        eventsObj.te_id = [respo valueForKey:@"id"];
        NSString *titleStr = [respo valueForKey:@"title"];
        eventsObj.title = [self base64DecodeString:titleStr];
        NSString *image_urlStr = [respo valueForKey:@"image_url"];
        eventsObj.image_url = [self base64DecodeString:image_urlStr];
        eventsObj.link = [respo valueForKey:@"link"];
        [[ResponseUtility getSharedInstance].TrendingEventsArray addObject:eventsObj];
      }
    }
    dispatch_async(dispatch_get_main_queue(), ^{
      [self hideProcessingScreen];
      [self.collectionViewHorizontal reloadData];
    });
    
  }
}

-(void)getDetailCategoriesData{
//  vc.cdate = [self getCurrentDate];
//  vc.cedate = [self getEndDate:[self getCurrentDate]];
//  vc.cid = selectedCId;
  NSDictionary *params = @{@"current_date":self.getCurrentDate,@"end_date":[self getEndDate:[self getCurrentDate]],@"category_id":selectedCId};
    [self addProccessingScreenWithText:@"Please wait.."];
  RequestUtility *utility = [RequestUtility sharedRequestUtility];
  NSString *url = @"http://developdreamz.com.md-70.webhostbox.net/barbados/category_events.php";
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
    
    [ResponseUtility getSharedInstance].CategoryDetailsArray = [[NSMutableArray alloc]init];
    if ([ResponseDictionary isKindOfClass:[NSDictionary class]]) {
      CategoryDetails *sEvents = [[CategoryDetails alloc]init];
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
      [[ResponseUtility getSharedInstance].CategoryDetailsArray addObject:sEvents];
    }
    else if ([ResponseDictionary isKindOfClass:[NSArray class]]){
      for (NSArray *respo in values){
        CategoryDetails *sEvents = [[CategoryDetails alloc]init];
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
        [[ResponseUtility getSharedInstance].CategoryDetailsArray addObject:sEvents];
      }
    }
    dispatch_async(dispatch_get_main_queue(), ^{
            [self hideProcessingScreen];
//      [self.tableVw reloadData];
      [self performSegueWithIdentifier:@"showCategoriesView" sender:nil];
    });
    
  }
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([[segue identifier] isEqualToString:@"showWebView"])
  {
    WebviewViewController *vc = [segue destinationViewController];
    vc.urlStr = webLink;
  }else if ([[segue identifier] isEqualToString:@"showSearchDetails"]){
    SearchDetailViewController *vc = [segue destinationViewController];
    vc.serachText = searchString;
  }else{
    CategoriesViewController *vc = [segue destinationViewController];
    vc.cdate = [self getCurrentDate];
    vc.cedate = [self getEndDate:[self getCurrentDate]];
    vc.cid = selectedCId;
  }
  
  
}


@end
