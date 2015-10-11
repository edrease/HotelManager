//
//  MainMenuTableViewController.m
//  HotelManagement
//
//  Created by Edrease Peshtaz on 10/5/15.
//  Copyright © 2015 cf. All rights reserved.
//

#import "MainMenuTableViewController.h"
#import "MainMenuOptionCell.h"
#import "HotelListViewController.h"
#import "BeginDateReservationViewController.h"
#import "SearchReservationsViewController.h"

@interface MainMenuTableViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong,nonatomic) NSArray *tableData;
@end

@implementation MainMenuTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  
  [self.tableView registerClass: [MainMenuOptionCell class] forCellReuseIdentifier:@"MainMenuTableCell"];
  self.tableData = [NSArray arrayWithObjects:NSLocalizedString(@"Browse Hotels",nil),NSLocalizedString(@"Book a Room",nil),NSLocalizedString(@"Lookup Reservations", nil),nil];
  
}


#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  MainMenuOptionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainMenuTableCell" forIndexPath:indexPath];
  
  cell.textLabel.text = [self.tableData objectAtIndex:indexPath.row];
  
  return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  HotelListViewController *hotelListVC = [[HotelListViewController alloc] init];
  BeginDateReservationViewController *beginDateVC = [[BeginDateReservationViewController alloc] init];
  SearchReservationsViewController *searchReservationsVC = [[SearchReservationsViewController alloc] init];
  switch (indexPath.row) {
    case 0:
      [self.navigationController pushViewController:hotelListVC animated:true];
      break;
    case 1:
      [self.navigationController pushViewController:beginDateVC animated:true];
      break;
    case 2:
      [self.navigationController pushViewController:searchReservationsVC animated:true];
      break;
    default:
      break;
  }
}






@end
