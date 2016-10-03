//
//  CategoriesViewController.m
//  TotallyBarbados
//
//  Created by Sudarshan on 6/26/16.
//  Copyright © 2016 Uniken. All rights reserved.
//

#import "CategoriesViewController.h"
#import "CategoryDateViewController.h"
#import "CategoryDetailViewController.h"
#import "CategoryLocationViewController.h"
#import "RequestUtility.h"
#import "ResponseUtility.h"
@interface CategoriesViewController ()<NKJPagerViewDataSource, NKJPagerViewDelegate>

@end

@implementation CategoriesViewController
@synthesize cdate,cid,cedate;
- (void)viewDidLoad
{
  self.title = @"TOTALLY BARBADOS";
  self.navigationController.navigationBarHidden = NO;
  self.dataSource = self;
  self.delegate = self;
  self.infiniteSwipe = NO;
  
  //
  //  current_date=2016-07-24&end_date=2016-7-31&category_id=70
  
  [super viewDidLoad];
}



#pragma mark - NKJPagerViewDataSource

- (NSUInteger)numberOfTabView
{
  return 3;
}

- (UIView *)viewPager:(NKJPagerViewController *)viewPager viewForTabAtIndex:(NSUInteger)index
{
  UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, 160.f, 44.f)];
  
//  CGFloat r = (arc4random_uniform(255) + 1.f) / 255.0;
//  CGFloat g = (arc4random_uniform(255) + 1.f) / 255.0;
//  CGFloat b = (arc4random_uniform(255) + 1.f) / 255.0;
//  UIColor *color = [UIColor colorWithRed:r green:g blue:b alpha:1.0];
  label.backgroundColor = [UIColor colorWithRed:240/255.0f green:167/255.0f blue:16/255.0f alpha:1.0f];//[UIColor yellowColor];
  label.font=[UIFont fontWithName:@"Helvetica-Bold" size: 16.0];
  
//  label.font = [UIFont systemFontOfSize:12.0];
  if (index == 0){
    label.text = [NSString stringWithFormat:@"Date"];
  }
  if (index == 1) {
    label.text = [NSString stringWithFormat:@"Category"];
  }
  if (index == 2) {
    label.text = [NSString stringWithFormat:@"Location"];
  }

  label.textAlignment = NSTextAlignmentCenter;
  label.textColor = [UIColor whiteColor];
  
  return label;
}

- (UIViewController *)viewPager:(NKJPagerViewController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index
{
  if (index == 0) {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CategoryDateViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"CategoryDateViewController"];
    vc.dateText = [NSString stringWithFormat:@"Content View date#%lu", index];
    return vc;
  }else if (index ==1) {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CategoryDetailViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"CategoryDetailViewController"];
    vc.detailText = [NSString stringWithFormat:@"Content View detail#%lu", index];
    vc.cdate = self.cdate;
    vc.cedate = self.cedate;
    vc.cid = self.cid;
    return vc;
  }else{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CategoryLocationViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"CategoryLocationViewController"];
    vc.locationTxt = [NSString stringWithFormat:@"Content View location#%lu", index];
    return vc;
  }
  
}

- (CGFloat)widthOfTabViewWithIndex:(NSInteger)index
{
  return 160.f;
}

#pragma mark - NKJPagerViewDelegate

- (void)viewPager:(NKJPagerViewController *)viewPager didSwitchAtIndex:(NSInteger)index withTabs:(NSArray *)tabs
{
  [UIView animateWithDuration:0.1f
                   animations:^{
                     for (UIView *view in self.tabs) {
                       if (index == view.tag) {
                         view.alpha = 1.f;
                       } else {
                         view.alpha = 0.9f;
                       }
                     }
                   }
                   completion:^(BOOL finished){}];
}

@end
