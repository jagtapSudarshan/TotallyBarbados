//
//  WebviewViewController.h
//  TotallyBarbados
//
//  Created by Sudarshan on 6/27/16.
//  Copyright © 2016 Uniken. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondaryViewController.h"
@interface WebviewViewController : SecondaryViewController
@property (weak, nonatomic) IBOutlet UIWebView *webVw;
@property(nonatomic,strong)NSString *urlStr;
@end
