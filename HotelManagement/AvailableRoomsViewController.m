//
//  AvailableRoomsViewController.m
//  HotelManagement
//
//  Created by Edrease Peshtaz on 10/7/15.
//  Copyright © 2015 cf. All rights reserved.
//

#import "AvailableRoomsViewController.h"
#import "Rooms.h"
#import "Hotel.h"
#import "Guest.h"
#import "Reservation.h"
#import "BeginDateReservationViewController.h"
#import "EndDateReservationViewController.h"
#import "ConfirmBookingViewController.h"

@interface AvailableRoomsViewController () <UITableViewDataSource, UITableViewDelegate>
@property UITableView *tableView;
@end

@implementation AvailableRoomsViewController
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
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"AvailableRoomCell"];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.availableRooms.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AvailableRoomCell" forIndexPath:indexPath];
  Rooms *room = self.availableRooms[indexPath.row];
  NSString *roomNumber = [NSString stringWithFormat:@"%@", room.number];
  cell.textLabel.text = roomNumber;
  return cell;
}

#pragma mark UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ConfirmBookingViewController *confirmBookingVC = [[ConfirmBookingViewController alloc] init];
    Rooms *room = self.availableRooms[indexPath.row];
    
    confirmBookingVC.selectedRoom = room;
    confirmBookingVC.beginDateToConfirm = self.startDate;
    confirmBookingVC.endDateToConfirm = self.endDate;
  
  
//    [self.dateFormatter setDateFormat:(@"MMMM EE yy")];
//    confirmBookingViewController.endDateToConfirm = self.datePicker.date;
//    confirmBookingViewController.beginDateToConfirm = self.selectedDate;
//  
//    BOOL testResult = [DateValidationService validRangeStartDate:self.startDate endDate:self.endDate];
//    NSLog(@"%d", (testResult));
    [self.navigationController pushViewController:confirmBookingVC animated:true];
}

@end
