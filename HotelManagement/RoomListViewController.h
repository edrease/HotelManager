//
//  RoomListViewController.h
//  HotelManagement
//
//  Created by Edrease Peshtaz on 9/9/15.
//  Copyright (c) 2015 cf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Hotel.h"
#import "Rooms.h"
#import "BeginDateReservationViewController.h"
@class HotelListViewController;
@class BeginDateReservationViewController;
@interface RoomListViewController : UIViewController
  @property Hotel *selectedHotel;
@end
