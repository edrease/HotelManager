//
//  SearchReservationsViewController.m
//  HotelManagement
//
//  Created by Edrease Peshtaz on 10/8/15.
//  Copyright © 2015 cf. All rights reserved.
//

#import "SearchReservationsViewController.h"
#import "AppDelegate.h"
#import "CoreDataStack.h"
#import "Guest.h"
#import "Reservation.h"
#import "Rooms.h"
#import "Hotel.h"
#import "ReservationSearchResultsViewController.h"


@interface SearchReservationsViewController () <UITextFieldDelegate>

@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) NSMutableArray *reservations;

@end


@implementation SearchReservationsViewController

- (void)loadView {
  UIView *rootView = [[UIView alloc] init];
  rootView.backgroundColor = [UIColor whiteColor];
  
  UILabel *searchPromptLabel = [[UILabel alloc] init];
  [searchPromptLabel setText:@"Enter a last name to search existing reservations"];
  searchPromptLabel.numberOfLines = 0;
  [rootView addSubview:searchPromptLabel];
  
  UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 300, 100, 50)];
  self.textField = textField;
  textField.layer.borderColor = [UIColor blackColor].CGColor;
  textField.layer.borderWidth = 1;
  textField.placeholder = @"Enter last name to search";
  [rootView addSubview:textField];
  
  UIButton *searchButton = [[UIButton alloc] init];
  [searchButton addTarget:self action:@selector(searchButtonPressed) forControlEvents:UIControlEventTouchUpInside];
  [searchButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
  [searchButton setTitle:@"Search" forState:UIControlStateNormal];
  [rootView addSubview:searchButton];
  
  
//constraints for search prompt label
  
  [searchPromptLabel setTranslatesAutoresizingMaskIntoConstraints:false];
  NSLayoutConstraint *searchPromptLabelCenterX = [NSLayoutConstraint constraintWithItem:searchPromptLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
  searchPromptLabelCenterX.active = true;
  
  NSLayoutConstraint *searchPromptTopConstraint = [NSLayoutConstraint constraintWithItem:searchPromptLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeTop multiplier:1.0 constant:100];
  searchPromptTopConstraint.active = true;
  
    NSLayoutConstraint *searchPromptLabelWidth = [NSLayoutConstraint constraintWithItem:searchPromptLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeWidth multiplier:0.5 constant:100];
  searchPromptLabelWidth.active = true;
  
  
//constraints for text field
  
  [textField setTranslatesAutoresizingMaskIntoConstraints:false];
  NSLayoutConstraint *textFieldCenterX = [NSLayoutConstraint constraintWithItem:textField attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
  textFieldCenterX.active = true;
  
  NSLayoutConstraint *textFieldTopConstraint = [NSLayoutConstraint constraintWithItem:textField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:searchPromptLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:16];
  textFieldTopConstraint.active = true;
  
  NSLayoutConstraint *textFieldWidth = [NSLayoutConstraint constraintWithItem:textField attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeWidth multiplier:0.5 constant:100];
  textFieldWidth.active = true;
  
//constraints for search button
  
  [searchButton setTranslatesAutoresizingMaskIntoConstraints:false];
  NSLayoutConstraint *searchButtonCenterX = [NSLayoutConstraint constraintWithItem:searchButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
  searchButtonCenterX.active = true;
  
  NSLayoutConstraint *searchButtonTopConstraint = [NSLayoutConstraint constraintWithItem:searchButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:textField attribute:NSLayoutAttributeBottom multiplier:1.0 constant:16];
  searchButtonTopConstraint.active = true;
  
  self.view = rootView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark helper methods

-(void)searchButtonPressed {
  NSLog(@"test");
  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
  NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"guest.lastName == %@", self.textField.text];
  fetchRequest.predicate = predicate;
  NSError *fetchError;
  NSArray *results = [appDelegate.coreDataStack.managedObjectContext executeFetchRequest:fetchRequest error:&fetchError];
  NSLog(@"%lu",(unsigned long)results.count);
  NSLog(@"%@", self.textField.text);
  
  ReservationSearchResultsViewController *reservationSearchResultsVC = [[ReservationSearchResultsViewController alloc] init];
  reservationSearchResultsVC.searchResults = results;
  [self.navigationController pushViewController:reservationSearchResultsVC animated:true];
  
}

#pragma mark UITextFieldDelegate

-(void)textFieldDidEndEditing:(UITextField *)textField {
  [self.textField resignFirstResponder];
}

@end
