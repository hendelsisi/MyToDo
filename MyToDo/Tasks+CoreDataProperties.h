//
//  Tasks+CoreDataProperties.h
//  MyToDo
//
//  Created by hend elsisi on 4/13/16.
//  Copyright © 2016 hend elsisi. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Tasks.h"

NS_ASSUME_NONNULL_BEGIN

@interface Tasks (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *taskAction;
@property (nullable, nonatomic, retain) NSString *taskDate;
@property (nullable, nonatomic, retain) NSString *taskNote;
@property (nullable, nonatomic, retain) NSString *taskReminder;
@property (nullable, nonatomic, retain) NSString *taskRepeat;
@property (nullable, nonatomic, retain) NSString *taskTitle;
@property (nullable, nonatomic, retain) NSString *tastTime;

@end

NS_ASSUME_NONNULL_END
