//
//  DataBaseManager.m
//  MyToDo
//
//  Created by hend elsisi on 4/18/16.
//  Copyright © 2016 hend elsisi. All rights reserved.
//

#import "DataBaseManager.h"
#import "Tasks.h"
#import "Header.h"
#import "AppDelegate.h"
@implementation DataBaseManager
-(void)storeNewTask:(ToDoItem *)item{
    id delegateContext = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegateContext managedObjectContext];
     Tasks *row=nil;
    row = (Tasks *) [NSEntityDescription
                            insertNewObjectForEntityForName:TASKS_ENTITY_NAME
                            inManagedObjectContext:context];
                             [row setTaskAction:item.taskAction];
                             [row setTaskDate:item.taskDate];
                             [row setTaskReminder:item.taskReminder];
                             [row setTaskRepeat:item.taskRepeat];
                             [row setTaskTitle:item.taskTitle];
                             [row setTaskNote:item.taskNote];
                             [row setTastTime:item.taskTime];
                             NSError *error = nil;
                             if (![context save:&error]) {
                                 NSLog(@"There's a problem: %@", error);
                                }
}

-(void)editTask:(NSString *)taskId andToDoItem:(ToDoItem *)item{
    id delegateContext = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegateContext managedObjectContext];
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:TASKS_ENTITY_NAME ];
    request.predicate=[NSPredicate predicateWithFormat:@"taskTitle = %@",taskId];
    NSError *error;
    NSArray *matches=[context executeFetchRequest:request error:&error];
    if(!error){
        if(!matches || ([matches count] > 1)){
            NSLog(@"error");
        }
        else if (![matches count]){
        }
        else{
            Tasks* row=[[context executeFetchRequest:request error:nil] lastObject];
            [row setTaskAction:item.taskAction];
            [row setTaskDate:item.taskDate];
            [row setTaskReminder:item.taskReminder];
            [row setTaskRepeat:item.taskRepeat];
            [row setTaskTitle:item.taskTitle];
            [row setTaskNote:item.taskNote];
            [row setTastTime:item.taskTime];
            NSError *error = nil;
            if (![context save:&error]) {
                NSLog(@"There's a problem: %@", error);
            }
        }
    }
    else{
        NSLog(@"error");
    }
}

@end
