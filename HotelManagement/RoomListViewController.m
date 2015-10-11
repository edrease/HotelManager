//
//  RoomListViewController.m
//  HotelManagement
//
//  Created by Edrease Peshtaz on 9/9/15.
//  Copyright (c) 2015 cf. All rights reserved.
//

#import "RoomListViewController.h"
#import "HotelListViewController.h"
#import "BeginDateReservationViewController.h"
@class HotelListViewController;
@interface RoomListViewController () <UITableViewDataSource, UITableViewDelegate>
  @property UITableView *tableView;
  @property NSArray *rooms;
@end

@implementation RoomListViewController

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
    self.tableView.delegate = self;
    self.rooms = [self.selectedHotel.rooms allObjects];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"RoomCell"];
  
  
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.rooms.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomCell" forIndexPath:indexPath];
  Rooms *room = self.rooms[indexPath.row];
  NSString *roomNumber = [NSString stringWithFormat:@"%@", room.number];
  cell.textLabel.text = roomNumber;
  return cell;
}

#pragma mark UITableViewDelegate

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//  BeginDateReservationViewController *beginDateReservation = [[BeginDateReservationViewController alloc] init];
//  indexPath = [tableView indexPathForSelectedRow];
//  Rooms *selectedRoom = self.rooms[indexPath.row];
//  beginDateReservation.roomToBook = selectedRoom;
//  [self.navigationController pushViewController:beginDateReservation animated:true];
//  
//}

@end
