//
//  EndDateReservationViewController.m
//  HotelManagement
//
//  Created by Edrease Peshtaz on 9/10/15.
//  Copyright (c) 2015 cf. All rights reserved.
//

#import "EndDateReservationViewController.h"
#import "BeginDateReservationViewController.h"
#import "ConfirmBookingViewController.h"
#import "DateValidationService.h"
#import "ReservationService.h"
#import "AvailableRoomsViewController.h"
@interface EndDateReservationViewController ()

@property (strong, nonatomic) UIDatePicker *datePicker;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) NSDate *startDate;
@property (strong, nonatomic) NSDate *endDate;
@property (strong, nonatomic) NSArray *availableRooms;

@end

@implementation EndDateReservationViewController


- (void)loadView {
  self.title = @"End Date";
  UIView *rootView = [[UIView alloc] init];
  rootView.backgroundColor = [UIColor whiteColor];
  self.datePicker = [[UIDatePicker alloc] init];
  
  [rootView addSubview: self.datePicker];
  
  UIButton *didConfirmReservationButton = [[UIButton alloc] init];
  [didConfirmReservationButton addTarget:self action:@selector(didConfirmReservationButton) forControlEvents:UIControlEventTouchUpInside];
  [didConfirmReservationButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
  [didConfirmReservationButton setTitle:@"Confirm Reservation" forState:UIControlStateNormal];
  [didConfirmReservationButton setTranslatesAutoresizingMaskIntoConstraints:false];
  [rootView addSubview:didConfirmReservationButton];
  
  NSLayoutConstraint *chooseEndDateButtonCenterX = [NSLayoutConstraint constraintWithItem:didConfirmReservationButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
  chooseEndDateButtonCenterX.active = true;
  NSLayoutConstraint *chooseEndDateButtonBottomConstraint = [NSLayoutConstraint constraintWithItem:didConfirmReservationButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-8];
  chooseEndDateButtonBottomConstraint.active = true;
  
  self.view = rootView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.startDate = self.selectedDate;
    NSLog(@"%@", self.selectedDate);
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didConfirmReservationButton {
//  ConfirmBookingViewController *confirmBookingViewController = [[ConfirmBookingViewController alloc] init];
//  [self.dateFormatter setDateFormat:(@"MMMM EE yy")];
//  confirmBookingViewController.endDateToConfirm = self.datePicker.date;
//  confirmBookingViewController.beginDateToConfirm = self.selectedDate;
//  
//  BOOL testResult = [DateValidationService validRangeStartDate:self.startDate endDate:self.endDate];
//  NSLog(@"%d", (testResult));
//  [self.navigationController pushViewController:confirmBookingViewController animated:true];
  self.endDate = self.datePicker.date;
  AvailableRoomsViewController *availableRoomsVC = [[AvailableRoomsViewController alloc] init];
  self.availableRooms = [ReservationService availableRoomsForStartDate:self.startDate endDate:self.endDate];
  availableRoomsVC.availableRooms = self.availableRooms;
  NSLog(@"%lu",(unsigned long)self.availableRooms.count);
  availableRoomsVC.startDate = self.startDate;
  availableRoomsVC.endDate = self.endDate;
  [self.navigationController pushViewController:availableRoomsVC animated:true];
}


@end
