//
//  ReservationServiceTests.m
//  HotelManagement
//
//  Created by Edrease Peshtaz on 10/9/15.
//  Copyright © 2015 cf. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AppDelegate.h"
#import "CoreDataStack.h"
#import "Rooms.h"
#import "Reservation.h"
#import "ReservationService.h"

@interface ReservationServiceTests : XCTestCase
@property (strong, nonatomic) Rooms *room1;
@property (strong, nonatomic) Rooms *room2;
@property (strong, nonatomic) Hotel *hotel1;
@property (strong, nonatomic) CoreDataStack *coreDataStack;
@property (strong, nonatomic) NSDate *startDate;
@property (strong, nonatomic) NSDate *endDate;
@end

@implementation ReservationServiceTests

- (void)setUp {
    [super setUp];
    CoreDataStack *coreDataStack = [[CoreDataStack alloc] init];
    self.coreDataStack = coreDataStack;
  
  
    self.room1.number = @101;
    self.room1.hotel = self.hotel1;
  
    self.room2.number = @201;
    self.room2.hotel = self.hotel1;
  
    NSError *error;
    [self.room1.managedObjectContext save:&error];
  
}

-(void)testInvalidDates {
  NSDateComponents *components = [[NSDateComponents alloc] init];
  [components setDay:10];
  [components setMonth:12];
  [components setYear:2015];
  
  NSDateComponents *endComponents = [[NSDateComponents alloc] init];
  [endComponents setDay:13];
  [endComponents setMonth:12];
  [endComponents setYear:2015];
  
  self.startDate = [[NSCalendar currentCalendar] dateFromComponents:components];
  self.endDate = [[NSCalendar currentCalendar] dateFromComponents:endComponents];
  
  NSArray *results = [ReservationService availableRoomsForStartDate:self.endDate endDate:self.startDate];
  
  XCTAssertEqual(results.count, 0);
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
  self.coreDataStack = nil;
  
  
  self.room1.number = nil;
  self.room1.hotel = nil;
  
  self.room2.number = nil;
  self.room2.hotel = nil;
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
