//
//  ReservationSearchResultsViewController.m
//  HotelManagement
//
//  Created by Edrease Peshtaz on 10/10/15.
//  Copyright © 2015 cf. All rights reserved.
//

#import "ReservationSearchResultsViewController.h"
#import "Reservation.h"
#import "Rooms.h"

@interface ReservationSearchResultsViewController () <UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@end

@implementation ReservationSearchResultsViewController

- (void)loadView {
  UIView *rootView = [[UIView alloc] init];
  
  UITableView *tableView = [[UITableView alloc] initWithFrame:rootView.frame style:UITableViewStylePlain];
  self.tableView = tableView;
  [tableView setTranslatesAutoresizingMaskIntoConstraints:false];
  [rootView addSubview:tableView];
  
  NSDictionary *views = @{@"tableView": tableView};
  
  NSArray *tableViewHorizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|" options:0 metrics:nil views:views];
  [rootView addConstraints:tableViewHorizontalConstraints];
  NSArray *tableViewVerticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView]|" options:0 metrics:nil views:views];
  [rootView addConstraints:tableViewVerticalConstraints];
  
  self.view = rootView;
  }
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ResultsCell"];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.searchResults.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ResultsCell" forIndexPath:indexPath];
  Reservation *reservation = self.searchResults[indexPath.row];
  Rooms *room = reservation.room;
  NSString *roomNumber = [NSString stringWithFormat:@"%@", room.number];
  cell.textLabel.text = roomNumber;
  return cell;
}

@end
