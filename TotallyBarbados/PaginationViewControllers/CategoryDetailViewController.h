//
//  CategoryDetailViewController.h
//  TotallyBarbados
//
//  Created by Sudarshan on 6/26/16.
//  Copyright © 2016 Uniken. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableVw;
@property (weak, nonatomic) IBOutlet UILabel *detailLbl;
@property NSString *detailText;
@property(nonatomic,strong)NSString *cdate;
@property(nonatomic,strong)NSString *cedate;
@property(nonatomic,strong)NSString *cid;
@end
