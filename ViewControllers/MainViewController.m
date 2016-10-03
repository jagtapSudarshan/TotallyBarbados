//
//  MainViewController.m
//  SidebarDemo
//
//  Created by Simon Ng on 10/11/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

#import "MainViewController.h"
#import "SWRevealViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"Home";
  SWRevealViewController *revealViewController = self.revealViewController;
  if ( revealViewController )
  {
    [self.sidebarButton setTarget: self.revealViewController];
    [self.sidebarButton setAction: @selector( revealToggle: )];
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
  }
  //  SWRevealViewController *revealViewController = self.revealViewController;
  //  if ( revealViewController )
  //  {
  //    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
  //    navBar.backgroundColor = [UIColor yellowColor];
  //    navBar.tintColor = [UIColor whiteColor];
  //    navBar.barStyle = UIBarStyleBlackTranslucent;
  //    [[UINavigationBar appearance] setTitleTextAttributes: @{
  //                                                            NSForegroundColorAttributeName: [UIColor blackColor],
  //                                                            NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:20.0f]
  //                                                            }];
  //
  //    UINavigationItem *navItem = [[UINavigationItem alloc] init];
  //    navItem.title = @"TOTALLY BARBADOS";
  //
  //
  //    UIButton *button1=[UIButton buttonWithType:UIButtonTypeCustom];
  //    [button1 setFrame:CGRectMake(10.0, 2.0, 45.0, 40.0)];
  //    [button1 addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
  //    [button1 setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
  //    UIBarButtonItem *button = [[UIBarButtonItem alloc]initWithCustomView:button1];
  //    navItem.leftBarButtonItem = button;
  //
  //    navBar.items = @[ navItem ];
  //    [[UIApplication sharedApplication].keyWindow addSubview:navBar];
  //  }
}

-(void)viewWillAppear:(BOOL)animated{
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end
