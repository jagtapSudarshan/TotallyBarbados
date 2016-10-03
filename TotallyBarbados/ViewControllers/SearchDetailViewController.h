//
//  SearchDetailViewController.h
//  TotallyBarbados
//
//  Created by Sudarshan on 6/27/16.
//  Copyright © 2016 Uniken. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
#import "SecondaryViewController.h"
@interface SearchDetailViewController : SecondaryViewController
@property (weak, nonatomic) IBOutlet UITableView *tableVw;
@property(nonatomic,strong)NSString *serachText;
@end
