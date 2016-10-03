//
//  LeftPanelViewController.m
//  Totally Barabados
//
//  Created by Sudarshan on 6/21/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

#import "LeftPanelViewController.h"


@interface LeftPanelViewController ()<UITableViewDataSource,UITableViewDelegate>{
  NSArray *menuItems;
}
@end

@implementation LeftPanelViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  menuItems = @[@"Home", @"Agenda", @"Barbados Events", @"PosterBoard", @"Stream"];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *simpleTableIdentifier = @"cellIdentifier";
  
  UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
  if (cell == nil)
  {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
  }
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  cell.imageView.image = [UIImage imageNamed:@"menu.png"];
  cell.textLabel.text = [menuItems objectAtIndex:indexPath.row];
  
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  switch (indexPath.row) {
    case 0:
      NSLog(@"%ld",indexPath.row);
      [self performSegueWithIdentifier:@"showMain" sender:nil];
      break;
    case 1:
      NSLog(@"%ld",indexPath.row);
      [self performSegueWithIdentifier:@"showAgenda" sender:nil];
      break;
    case 2:
      NSLog(@"%ld",indexPath.row);
      [self performSegueWithIdentifier:@"showEvents" sender:nil];
      break;
    case 3:
      NSLog(@"%ld",indexPath.row);
      [self performSegueWithIdentifier:@"showPoaster" sender:nil];
      break;
    case 4:
      NSLog(@"%ld",indexPath.row);
      [self performSegueWithIdentifier:@"showStream" sender:nil];
      break;
      
    default:
      NSLog(@"%ld",indexPath.row);
      break;
  }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
  // Set the title of navigation bar by using the menu items
  NSIndexPath *indexPath = [self.listView indexPathForSelectedRow];
  UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
  destViewController.title = [[menuItems objectAtIndex:indexPath.row] capitalizedString];
  
  // Set the photo if it navigates to the PhotoView
  if ([segue.identifier isEqualToString:@"showPhoto"]) {
    //    UINavigationController *navController = segue.destinationViewController;
    //    PhotoViewController *photoController = [navController childViewControllers].firstObject;
    //    NSString *photoFilename = [NSString stringWithFormat:@"bookmark_photo"];
    //    photoController.photoFilename = photoFilename;
  }
}

@end
