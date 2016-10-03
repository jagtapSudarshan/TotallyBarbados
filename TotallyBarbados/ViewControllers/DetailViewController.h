//
//  DetailViewController.h
//  TotallyBarbados
//
//  Created by Sudarshan on 6/27/16.
//  Copyright © 2016 Uniken. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
#import "SecondaryViewController.h"
#import <MapKit/MKAnnotation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
@interface DetailViewController : SecondaryViewController
@property (weak, nonatomic) IBOutlet UILabel *mainTitleLbl;
@property (weak, nonatomic) IBOutlet AsyncImageView *imgView;
@property (weak, nonatomic) IBOutlet MKMapView *mapVw;
@property (weak, nonatomic) IBOutlet UILabel *dateTimeLbl;
@property (weak, nonatomic) IBOutlet UIWebView *webVw;
@property(nonatomic,strong)NSString *postId;
@property (weak, nonatomic) IBOutlet UILabel *venueLbl;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@end
