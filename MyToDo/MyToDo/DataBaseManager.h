//
//  DataBaseManager.h
//  MyToDo
//
//  Created by hend elsisi on 4/18/16.
//  Copyright © 2016 hend elsisi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ToDoItem.h"
@interface DataBaseManager : NSObject
-(void)editTask:(NSString*)taskId andToDoItem:(ToDoItem*)item;
-(void)storeNewTask:(ToDoItem*)item;
@end
