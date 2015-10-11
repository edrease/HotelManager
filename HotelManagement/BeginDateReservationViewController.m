//
//  BeginDateReservationViewController.m
//  HotelManagement
//
//  Created by Edrease Peshtaz on 9/10/15.
//  Copyright (c) 2015 cf. All rights reserved.
//

#import "BeginDateReservationViewController.h"
#import "EndDateReservationViewController.h"
@interface BeginDateReservationViewController ()

@property (strong, nonatomic) UIDatePicker *datePicker;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) NSDate *selectedDate;

@end

@implementation BeginDateReservationViewController
- (void)loadView {
  self.title = @"Start Date";
  UIView *rootView = [[UIView alloc] init];
  rootView.backgroundColor = [UIColor whiteColor];
  self.datePicker = [[UIDatePicker alloc] init];
  
  [rootView addSubview: self.datePicker];
  
  UIButton *chooseEndDateButton = [[UIButton alloc] init];
  [chooseEndDateButton addTarget:self action:@selector(chooseEndDateButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
  [chooseEndDateButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
  [chooseEndDateButton setTitle:@"Choose End Date" forState:UIControlStateNormal];
  [chooseEndDateButton setTranslatesAutoresizingMaskIntoConstraints:false];
  [rootView addSubview:chooseEndDateButton];
  
  NSLayoutConstraint *chooseEndDateButtonCenterX = [NSLayoutConstraint constraintWithItem:chooseEndDateButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
  chooseEndDateButtonCenterX.active = true;
  NSLayoutConstraint *chooseEndDateButtonBottomConstraint = [NSLayoutConstraint constraintWithItem:chooseEndDateButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-8];
  chooseEndDateButtonBottomConstraint.active = true;
  
  self.view = rootView;
}
   
//- (void)datePickerValueDidChange:(UIDatePicker *)sender {
//  [self.dateFormatter setDateFormat:@"MMMM EE yy"];
//  NSString *dateString = [self.dateFormatter stringFromDate:sender.date];
//  NSLog(@"%@", dateString);
//}

- (void)chooseEndDateButtonPressed:(UIButton *)sender {
  EndDateReservationViewController *endDateReservationViewController = [[EndDateReservationViewController alloc] init];
  [self.dateFormatter setDateFormat:(@"MMMM EE yy")];
  endDateReservationViewController.selectedDate = self.datePicker.date;
  endDateReservationViewController.roomToBook = self.roomToBook;
  [self.navigationController pushViewController:endDateReservationViewController animated:true];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    self.dateFormatter = [[NSDateFormatter alloc] init];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
