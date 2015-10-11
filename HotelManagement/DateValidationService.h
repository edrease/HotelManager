//
//  DateValidationService.h
//  HotelManagement
//
//  Created by Edrease Peshtaz on 9/14/15.
//  Copyright (c) 2015 cf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateValidationService : NSObject

+ (BOOL)validRangeStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;

@end
