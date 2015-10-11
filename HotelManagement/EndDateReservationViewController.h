//
//  EndDateReservationViewController.h
//  HotelManagement
//
//  Created by Edrease Peshtaz on 9/10/15.
//  Copyright (c) 2015 cf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Rooms.h"
@class BeginDateReservationViewController;
@class ConfirmBookingViewController;
@class AvailableRoomsViewController;
@interface EndDateReservationViewController : UIViewController
  @property (strong, nonatomic) NSDate *selectedDate;
  @property (strong, nonatomic) Rooms *roomToBook;
@end
