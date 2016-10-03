//
//  WebviewViewController.m
//  TotallyBarbados
//
//  Created by Sudarshan on 6/27/16.
//  Copyright © 2016 Uniken. All rights reserved.
//

#import "WebviewViewController.h"

@interface WebviewViewController ()<UIWebViewDelegate>

@end

@implementation WebviewViewController
@synthesize urlStr;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"TOTALLY BARBADOS";
  self.webVw.scalesPageToFit = YES;
  self.navigationController.navigationBarHidden = YES;
    // Do any additional setup after loading the view.
  [self.webVw loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
//  [self.webVw addProccessingScreenWithText:@"Please wait.."];
  NSString *text = @"Please wait..";
  self.processingScreen.hidden = NO;
  self.processingScreen.progressBar.progress = 0.0;
  self.processingScreen.activityIndicator.hidden = NO;
  [self.processingScreen.activityIndicator startAnimating];
  if (text) {
    [self.webVw addSubview:self.processingScreen];
    [self.processingScreen.progressLabel setText:text];
    [self.webVw bringSubviewToFront:self.processingScreen];
  }else{
    self.processingScreen.progressLabel.hidden = YES;
    self.processingScreen.activityIndicator.hidden = YES;
  }
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
  [self hideProcessingScreen];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
