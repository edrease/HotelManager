//
//  Hotel.h
//  HotelManagement
//
//  Created by Edrease Peshtaz on 9/8/15.
//  Copyright (c) 2015 cf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Rooms;

@interface Hotel : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * stars;
@property (nonatomic, retain) NSSet *rooms;
@end

@interface Hotel (CoreDataGeneratedAccessors)

- (void)addRoomsObject:(Rooms *)value;
- (void)removeRoomsObject:(Rooms *)value;
- (void)addRooms:(NSSet *)values;
- (void)removeRooms:(NSSet *)values;

@end
