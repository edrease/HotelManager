//
//  Rooms.h
//  HotelManagement
//
//  Created by Edrease Peshtaz on 9/8/15.
//  Copyright (c) 2015 cf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Hotel;

@interface Rooms : NSManagedObject

@property (nonatomic, retain) NSNumber * number;
@property (nonatomic, retain) Hotel *hotel;

@end
