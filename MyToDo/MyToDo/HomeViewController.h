//
//  ViewController.h
//  MyToDo
//
//  Created by hend elsisi on 3/29/16.
//  Copyright © 2016 hend elsisi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface HomeViewController : UIViewController<NSFetchedResultsControllerDelegate>

@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (weak, nonatomic) IBOutlet UITableView *tasksTableView;


@end

