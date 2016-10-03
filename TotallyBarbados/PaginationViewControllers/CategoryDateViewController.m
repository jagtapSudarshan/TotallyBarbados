//
//  CategoryDateViewController.m
//  TotallyBarbados
//
//  Created by Sudarshan on 6/26/16.
//  Copyright © 2016 Uniken. All rights reserved.
//

#import "CategoryDateViewController.h"

@interface CategoryDateViewController ()

@end

@implementation CategoryDateViewController
@synthesize dateLbl,dateText;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  self.dateLbl.text = dateText;
    self.title = @"TOTALLY BARBADOS";
    self.navigationController.navigationBarHidden = YES;
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
