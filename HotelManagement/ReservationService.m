//
//  ReservationService.m
//  HotelManagement
//
//  Created by Edrease Peshtaz on 9/14/15.
//  Copyright (c) 2015 cf. All rights reserved.
//

#import "ReservationService.h"
#import "CoreDataStack.h"
#import "Reservation.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "DateValidationService.h"

@implementation ReservationService

+ (NSArray *)availableRoomsForStartDate:(NSDate *)startDate endDate:(NSDate *)endDate {
  
  if (!startDate || !endDate) {
    return [[NSArray alloc] init];
  }
  
  BOOL validatedDate = [DateValidationService validRangeStartDate:startDate endDate:endDate];
  
  if (validatedDate == false) {
    return [[NSArray alloc] init];
  }
  
  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
  
  NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"startDate <= %@ AND endDate >= %@", endDate, startDate];
  
  request.predicate = predicate;
  NSError *fetchError;
  NSArray *results = [appDelegate.coreDataStack.managedObjectContext executeFetchRequest:request error:&fetchError];
  
  NSMutableArray *badRooms = [[NSMutableArray alloc] init];
  
  for (Reservation *reservation in results) {
    [badRooms addObject:reservation.room];
  }
  
  NSFetchRequest *finalRequest = [NSFetchRequest fetchRequestWithEntityName:@"Rooms"];
  NSPredicate *finalPredicate = [NSPredicate predicateWithFormat:@"NOT self IN %@", badRooms];
  finalRequest.predicate = finalPredicate;
  
  NSError *finalError;
  
  NSArray *finalResults = [appDelegate.coreDataStack.managedObjectContext executeFetchRequest:finalRequest error:&finalError];
  
  if (finalError) {
    return nil;
  }
  
  return finalResults;
}

@end
