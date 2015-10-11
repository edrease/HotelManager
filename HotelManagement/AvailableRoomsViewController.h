//
//  AvailableRoomsViewController.h
//  HotelManagement
//
//  Created by Edrease Peshtaz on 10/7/15.
//  Copyright © 2015 cf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Rooms.h"
@class EndDateReservationViewController;
@interface AvailableRoomsViewController : UIViewController

@property (strong, nonatomic) NSArray *availableRooms;
@property (strong, nonatomic) NSDate *startDate;
@property (strong, nonatomic) NSDate *endDate;

@end
