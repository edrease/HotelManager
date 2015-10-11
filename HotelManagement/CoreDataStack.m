//
//  CoreDataStack.m
//  HotelManagement
//
//  Created by Edrease Peshtaz on 10/5/15.
//  Copyright © 2015 cf. All rights reserved.
//

#import "CoreDataStack.h"
#import "Rooms.h"
#import "Hotel.h"

@implementation CoreDataStack

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (instancetype)init
{
  self = [super init];
  if (self) {
    [self seedCoreData];
  }
  return self;
}

- (NSURL *)applicationDocumentsDirectory {
  // The directory the application uses to store the Core Data store file. This code uses a directory named "cf.HotelManagement" in the application's documents directory.
  return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
  // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
  if (_managedObjectModel != nil) {
    return _managedObjectModel;
  }
  NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"HotelManagement" withExtension:@"momd"];
  _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
  return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
  // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
  if (_persistentStoreCoordinator != nil) {
    return _persistentStoreCoordinator;
  }
  
  // Create the coordinator and store
  
  _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
  NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"HotelManagement.sqlite"];
  NSError *error = nil;
  NSString *failureReason = @"There was an error creating or loading the application's saved data.";
  if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
    // Report any error we got.
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
    dict[NSLocalizedFailureReasonErrorKey] = failureReason;
    dict[NSUnderlyingErrorKey] = error;
    error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
    // Replace this with code to handle the error appropriately.
    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    abort();
  }
  
  return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
  // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
  if (_managedObjectContext != nil) {
    return _managedObjectContext;
  }
  
  NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
  if (!coordinator) {
    return nil;
  }
  _managedObjectContext = [[NSManagedObjectContext alloc] init];
  [_managedObjectContext setPersistentStoreCoordinator:coordinator];
  return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
  NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
  if (managedObjectContext != nil) {
    NSError *error = nil;
    if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
      // Replace this implementation with code to handle the error appropriately.
      // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
      NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
      abort();
    }
  }
}


-(void)seedCoreData {
  
  NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
  fetchRequest.resultType = NSFetchRequestType;
  NSError *fetchError;
  NSInteger count = [self.managedObjectContext countForFetchRequest:fetchRequest error:&fetchError];
  
  if (count == 0) {
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"hotels" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    NSError *jsonError;
    
    NSDictionary *rootObject = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&jsonError];
    
    if (jsonError) {
      return;
    }
    
    else {
      
      NSDictionary *hotels = [rootObject objectForKey:@"Hotels"];
      
      for (NSDictionary *hotel in hotels) {
        NSString *name = [hotel objectForKey:@"name"];
        //        NSString *locatoin = [hotel objectForKey:@"location"];
        NSNumber *stars = [hotel objectForKey:@"stars"];
        NSDictionary *rooms = [hotel objectForKey:@"rooms"];
        
        
        Hotel *construcedHotel = [NSEntityDescription insertNewObjectForEntityForName:@"Hotel" inManagedObjectContext:self.managedObjectContext];
        construcedHotel.name = name;
        construcedHotel.stars = stars;
        
        for (NSDictionary *roomInfo in rooms) {
          NSNumber *roomNumber = [roomInfo objectForKey:@"number"];
          
          Rooms *constructedRoom = [NSEntityDescription insertNewObjectForEntityForName:@"Rooms" inManagedObjectContext:self.managedObjectContext];
          
          constructedRoom.number = roomNumber;
          constructedRoom.hotel = construcedHotel;
        }
        
      }
      
    }
    
  }
  
  //  //Trump International New York
  //  Hotel *trumpNewYork = [NSEntityDescription insertNewObjectForEntityForName:@"Hotel" inManagedObjectContext:self.managedObjectContext];
  //  trumpNewYork.name = @"Trump International New York";
  //  trumpNewYork.stars = @5;
  //
  //  Rooms *room1 = [NSEntityDescription insertNewObjectForEntityForName:@"Rooms" inManagedObjectContext:self.managedObjectContext];
  //  room1.number = @1;
  //  room1.hotel = trumpNewYork;
  //
  //  //Trump International Las Vegas
  //  Hotel *trumpLasVegas = [NSEntityDescription insertNewObjectForEntityForName:@"Hotel" inManagedObjectContext:self.managedObjectContext];
  //  trumpLasVegas.name = @"Trump International Las Vegas";
  //  trumpLasVegas.stars = @5;
  //
  //  Rooms *room2 = [NSEntityDescription insertNewObjectForEntityForName:@"Rooms" inManagedObjectContext:self.managedObjectContext];
  //  room2.number = @2;
  //  room2.hotel = trumpLasVegas;
  //
  //  //Trump National Doral Miami
  //  Hotel *trumpMiami = [NSEntityDescription insertNewObjectForEntityForName:@"Hotel" inManagedObjectContext:self.managedObjectContext];
  //  trumpMiami.name = @"Trump National Doral Miami";
  //  trumpMiami.stars = @5;
  //
  //  Rooms *room3 = [NSEntityDescription insertNewObjectForEntityForName:@"Rooms" inManagedObjectContext:self.managedObjectContext];
  //  room3.number = @3;
  //  room3.hotel = trumpMiami;
}

@end
