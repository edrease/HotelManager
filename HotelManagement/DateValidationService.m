//
//  DateValidationService.m
//  HotelManagement
//
//  Created by Edrease Peshtaz on 9/14/15.
//  Copyright (c) 2015 cf. All rights reserved.
//

#import "DateValidationService.h"

@implementation DateValidationService

+ (BOOL)validRangeStartDate:(NSDate *)startDate endDate:(NSDate *)endDate {
  return [startDate compare:endDate] == NSOrderedAscending ? true : false;
}

@end
