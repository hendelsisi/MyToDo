//
//  AppDelegate.h
//  MyToDo
//
//  Created by hend elsisi on 3/29/16.
//  Copyright © 2016 hend elsisi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Header.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property TargetToSelect target;
@property BOOL emptyCoreData;

@property (strong, nonatomic) UIWindow *window;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

