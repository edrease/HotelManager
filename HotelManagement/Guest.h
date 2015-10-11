//
//  Guest.h
//  HotelManagement
//
//  Created by Edrease Peshtaz on 9/14/15.
//  Copyright (c) 2015 cf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Reservation;

@interface Guest : NSManagedObject

@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) Reservation *reservation;

@end
