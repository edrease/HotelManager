//
//  ConfirmBookingViewController.m
//  HotelManagement
//
//  Created by Edrease Peshtaz on 9/13/15.
//  Copyright (c) 2015 cf. All rights reserved.
//

#import "ConfirmBookingViewController.h"
#import "EndDateReservationViewController.h"
#import "Reservation.h"
#import "CoreDataStack.h"
#import "AppDelegate.h"
#import "Guest.h"
@interface ConfirmBookingViewController () <UITextFieldDelegate>

@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) UITextField *textField;

@end

@implementation ConfirmBookingViewController

- (void)loadView {
  UIView *rootView = [[UIView alloc] init];
  self.dateFormatter = [[NSDateFormatter alloc] init];
  [self.dateFormatter setDateFormat:@"EEEE MMMM d yyyy"];
  
  NSString *beginLabelText = [self.dateFormatter stringFromDate:self.beginDateToConfirm];
  NSString *endDateLabelText = [self.dateFormatter stringFromDate:self.endDateToConfirm];
  NSLog(@"%@ shit",beginLabelText);
  UILabel *confirmationDetailsLabel = [[UILabel alloc] init];
  confirmationDetailsLabel.numberOfLines = 0;
  NSString *roomNumber = [NSString stringWithFormat:@"Do you want to confrim these dates for room %@?", self.selectedRoom.number];
  [confirmationDetailsLabel setText: roomNumber];
  
  UILabel *beginDateLabel = [[UILabel alloc] init];
  [beginDateLabel setText:beginLabelText];
  [rootView addSubview:beginDateLabel];
  
  UILabel *endDateLabel = [[UILabel alloc] init];
  [endDateLabel setText:endDateLabelText];
  [rootView addSubview:endDateLabel];
  
  UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 300, 100, 50)];
  self.textField = textField;
  textField.layer.borderColor = [UIColor blackColor].CGColor;
  textField.layer.borderWidth = 1;
  textField.placeholder = @"Enter last name to book";
  [rootView addSubview:textField];
  
  UIButton *confirmReservationButton = [[UIButton alloc] init];
  [confirmReservationButton addTarget:self action:@selector(didConfirmReservationButtonPressed) forControlEvents:UIControlEventTouchUpInside];
  [confirmReservationButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
  [confirmReservationButton setTitle:@"Confirm" forState:UIControlStateNormal];
  [confirmReservationButton setTranslatesAutoresizingMaskIntoConstraints:false];
  [rootView addSubview:confirmReservationButton];
  
  
  
  rootView.backgroundColor = [UIColor whiteColor];
  [confirmationDetailsLabel setTranslatesAutoresizingMaskIntoConstraints:false];
  [rootView addSubview:confirmationDetailsLabel];
  

  
  

//Constraints for confirmation label
  NSLayoutConstraint *confirmationDetailsLabelCenterX = [NSLayoutConstraint constraintWithItem:confirmationDetailsLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
  confirmationDetailsLabelCenterX.active = true;
  
  NSLayoutConstraint *confirmationDetailsLabelTopConstraint = [NSLayoutConstraint constraintWithItem:confirmationDetailsLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeTop multiplier:1.0 constant:100];
  confirmationDetailsLabelTopConstraint.active = true;

  NSLayoutConstraint *confirmationLabelWidth = [NSLayoutConstraint constraintWithItem:confirmationDetailsLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeWidth multiplier:0.5 constant:100];
    confirmationLabelWidth.active = true;
//constraints for begin date label
  [beginDateLabel setTranslatesAutoresizingMaskIntoConstraints:false];
  NSLayoutConstraint *beginDateLabelCenterX = [NSLayoutConstraint constraintWithItem:beginDateLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
  beginDateLabelCenterX.active = true;
  
  NSLayoutConstraint *beginDateLabelTopConstraint = [NSLayoutConstraint constraintWithItem:beginDateLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:confirmationDetailsLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:16];
  beginDateLabelTopConstraint.active = true;
  
//constraints for end date label
  [endDateLabel setTranslatesAutoresizingMaskIntoConstraints:false];
  NSLayoutConstraint *endDateLabelCenterX = [NSLayoutConstraint constraintWithItem:endDateLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
  endDateLabelCenterX.active = true;
  
  NSLayoutConstraint *endDateLabelTopConstraint = [NSLayoutConstraint constraintWithItem:endDateLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:beginDateLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:16];
  endDateLabelTopConstraint.active = true;
  
//constraints for text field
  
  [textField setTranslatesAutoresizingMaskIntoConstraints:false];
  NSLayoutConstraint *textFieldCenterX = [NSLayoutConstraint constraintWithItem:textField attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
  textFieldCenterX.active = true;
  
  NSLayoutConstraint *textFieldTopConstraint = [NSLayoutConstraint constraintWithItem:textField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:endDateLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:16];
  textFieldTopConstraint.active = true;
  
  NSLayoutConstraint *textFieldWidth = [NSLayoutConstraint constraintWithItem:textField attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeWidth multiplier:0.5 constant:100];
  textFieldWidth.active = true;
  
//constraints for did confirm reservation button
  
  NSLayoutConstraint *confirmReservationButtonCenterX = [NSLayoutConstraint constraintWithItem:confirmReservationButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
  confirmReservationButtonCenterX.active = true;
  
  NSLayoutConstraint *confirmReservationTopConstraint = [NSLayoutConstraint constraintWithItem:confirmReservationButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:textField attribute:NSLayoutAttributeBottom multiplier:1.0 constant:16];
  confirmReservationTopConstraint.active = true;
  
  self.view = rootView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  self.textField.delegate = self;
  NSLog(@"%@ %@", self.beginDateToConfirm, self.endDateToConfirm);
  NSString *roomNumber = [NSString stringWithFormat:@"%@", self.selectedRoom.number];
  NSLog(@"%@", roomNumber);
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
    // Dispose of any resources that can be recreated.
}

#pragma mark UITextFieldDelegate

-(void)textFieldDidEndEditing:(UITextField *)textField {
//  Guest *guest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:self.selectedRoom.managedObjectContext];
//  guest.lastName = textField.text;
//  self.selectedGuest = guest;
//  NSLog(@"%@",self.selectedGuest.lastName);
  [self.textField resignFirstResponder];
}

#pragma mark helper methods

-(void)didConfirmReservationButtonPressed {
  Reservation *bookedReservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:self.selectedRoom.managedObjectContext];
  
  Guest *guest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:self.selectedRoom.managedObjectContext];
  guest.lastName = self.textField.text;
  self.selectedGuest = guest;
  NSLog(@"%@",self.selectedGuest.lastName);

  bookedReservation.room = self.selectedRoom;
  bookedReservation.guest = self.selectedGuest;
  bookedReservation.startDate = self.beginDateToConfirm;
  bookedReservation.endDate = self.endDateToConfirm;
  NSError *error;
  [self.selectedRoom.managedObjectContext save:&error];
  if (error) {
    NSLog(@"%@", error.localizedDescription);
  } else {
  [self.navigationController popToRootViewControllerAnimated:true];
  }
  
}

@end
