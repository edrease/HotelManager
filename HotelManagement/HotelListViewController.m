//
//  HotelListViewController.m
//  HotelManagement
//
//  Created by Edrease Peshtaz on 9/8/15.
//  Copyright (c) 2015 cf. All rights reserved.
//

#import "HotelListViewController.h"
#import "AppDelegate.h"
#import "Hotel.h"
#import "Rooms.h"
#import "RoomListViewController.h"
#import "CoreDataStack.h"
@class RoomListViewController;

@interface HotelListViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *hotels;
@end

@implementation HotelListViewController

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
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"HotelCell"];
  
  
  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
  NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
  NSError *fetchError;
//  self.hotels = [coreData.managedObjectContext executeFetchRequest:fetchRequest error:&fetchError];
  self.hotels = [appDelegate.coreDataStack.managedObjectContext executeFetchRequest:fetchRequest error:&fetchError];
  if (fetchError) {
    NSLog(@"%@", fetchError.localizedDescription);
  }
  
  
  [self.tableView reloadData];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.hotels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HotelCell" forIndexPath:indexPath];
  
  Hotel *hotel = self.hotels[indexPath.row];
  cell.textLabel.text = hotel.name;
  return cell;
}

#pragma mark UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  RoomListViewController *roomListViewController = [[RoomListViewController alloc] init];
  indexPath = [tableView indexPathForSelectedRow];
  Hotel *selectedHotel = self.hotels[indexPath.row];
  roomListViewController.selectedHotel = selectedHotel;
  [self.navigationController pushViewController:roomListViewController animated:true];
}

@end
