//
//  AgendaViewController.m
//  Totally Barabados
//
//  Created by Sudarshan on 6/21/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

#import "AgendaViewController.h"
#import "SWRevealViewController.h"
@interface AgendaViewController ()

@end

@implementation AgendaViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"Agenda";
  SWRevealViewController *revealViewController = self.revealViewController;
  if ( revealViewController )
  {
    [self.sidebarButton setTarget: self.revealViewController];
    [self.sidebarButton setAction: @selector( revealToggle: )];
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
  }
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
