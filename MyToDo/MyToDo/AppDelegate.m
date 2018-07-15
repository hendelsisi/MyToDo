//
//  AppDelegate.m
//  MyToDo
//
//  Created by hend elsisi on 3/29/16.
//  Copyright © 2016 hend elsisi. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "Tasks.h"
#import "MFSideMenu.h"
#import "Header.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
    HomeViewController *controller = (HomeViewController *)navigationController.topViewController;
    controller.managedObjectContext = self.managedObjectContext;
   
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:TASKS_ENTITY_NAME ];
    
    NSError *error;
    NSArray *matches=[_managedObjectContext executeFetchRequest:request error:&error];
    if([matches count] == 0)
    { // _emptyCoreData = YES;
        [self store];
    }
    return YES;
}

-(void)store{
    
    Tasks *first = (Tasks *) [NSEntityDescription
                                insertNewObjectForEntityForName:TASKS_ENTITY_NAME
                                inManagedObjectContext:[self managedObjectContext]];
    first.taskTitle = @"Core Data for iOS and OS X";
    first.taskDate=@"31 Mar 2016";
    first.taskAction=@"SMS";
    first.taskReminder=@"ON DUE";
    first.taskRepeat=@"MONTHLY";
    first.tastTime=@"12:50 AM";
    first.taskNote=@"There are moms fighting over the last toy her child wants and someone fighting over the last chocolate chip cookie at the cookie corner.";
    
    Tasks *second = (Tasks *) [NSEntityDescription
                              insertNewObjectForEntityForName:@"Tasks"
                              inManagedObjectContext:[self managedObjectContext]];
    second.taskTitle = @"C/C++ Essential Training";
    second.taskDate=@"31 Mar 2016";
    second.taskAction=@"SMS";
    second.taskReminder=@"ON DUE";
    second.taskRepeat=@"MONTHLY";
    second.taskNote=@"There are moms fighting over the last toy her child wants and someone fighting over the last chocolate chip cookie at the cookie corner.";
    second.tastTime = @"12:09 AM";
    Tasks *third = (Tasks *) [NSEntityDescription
                               insertNewObjectForEntityForName:@"Tasks"
                               inManagedObjectContext:[self managedObjectContext]];
    third.taskTitle = @"Java Essential Training";
    third.taskDate=@"31 Mar 2016";
    third.taskAction=@"SMS";
    third.taskReminder=@"ON DUE";
    third.taskRepeat=@"MONTHLY";
    third.tastTime = @"02:59 PM";
    third.taskNote=@"There are moms fighting over the last toy her child wants and someone fighting over the last chocolate chip cookie at the cookie corner.";
    
    
    Tasks *forth = (Tasks *) [NSEntityDescription
                              insertNewObjectForEntityForName:@"Tasks"
                              inManagedObjectContext:[self managedObjectContext]];
    forth.taskTitle = @"iOS SDK: Building Apps with MapKit and Core Location";
    forth.taskDate=@"31 Mar 2016";
    forth.taskAction=@"SMS";
    forth.taskReminder=@"ON DUE";
    forth.taskRepeat=@"MONTHLY";
    forth.tastTime = @"12:59 AM";
    forth.taskNote=@"There are moms fighting over the last toy her child wants and someone fighting over the last chocolate chip cookie at the cookie corner.";
    Tasks *fifth = (Tasks *) [NSEntityDescription
                              insertNewObjectForEntityForName:@"Tasks"
                              inManagedObjectContext:[self managedObjectContext]];
    fifth.taskTitle = @"Cocoa Essential Training";
    fifth.taskDate=@"31 Mar 2016";
    fifth.taskAction=@"SMS";
    fifth.taskReminder=@"ON DUE";
    fifth.taskRepeat=@"MONTHLY";
    fifth.tastTime = @"12:59 AM";
    fifth.taskNote=@"There are moms fighting over the last toy her child wants and someone fighting over the last chocolate chip cookie at the cookie corner.";
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"There's a problem: %@", error);
    }
    
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.ios.MyToDo" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"MyToDo" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"MyToDo.sqlite"];
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
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
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

@end
