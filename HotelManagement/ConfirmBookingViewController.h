//
//  ConfirmBookingViewController.h
//  HotelManagement
//
//  Created by Edrease Peshtaz on 9/13/15.
//  Copyright (c) 2015 cf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Rooms.h"
#import "Guest.h"
@class EndDateReservationViewController;
@interface ConfirmBookingViewController : UIViewController

@property NSDate *beginDateToConfirm;
@property NSDate *endDateToConfirm;
@property Rooms *selectedRoom;
@property Guest *selectedGuest;

@end
