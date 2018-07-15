//
//  ViewController.m
//  MyToDo
//
//  Created by hend elsisi on 3/29/16.
//  Copyright © 2016 hend elsisi. All rights reserved.
//

#import "HomeViewController.h"
#import "CompactViewCell.h"
#import "Tasks.h"
#import "AppDelegate.h"
#import "DetailsViewController.h"
#import "Header.h"
@interface HomeViewController ()

@property NSIndexPath* expandedCellIndexPath;
@property int countTaps;
@property BOOL doubleClick;


@end

@implementation HomeViewController
@synthesize managedObjectContext;
@synthesize fetchedResultsController = _fetchedResultsController;


- (void)viewDidLoad {
    [super viewDidLoad];
    [self addGesture];
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
    doubleTap.numberOfTapsRequired = 2;
    doubleTap.delegate = self;
    [self.view addGestureRecognizer:doubleTap];
    if ([(AppDelegate *)[[UIApplication sharedApplication] delegate] emptyCoreData]==YES) {
        self.tasksTableView.hidden = YES;
    }
    NSError *error;
    if (![[self fetchedResultsController] performFetch:&error]) {
       
    }
}

-(void)doubleTap:(UITapGestureRecognizer*)tap{
    _doubleClick = YES;
    CGPoint location = [tap locationInView:_tasksTableView];
    NSIndexPath *indexPath = [_tasksTableView indexPathForRowAtPoint:location];
    [self performSegueWithIdentifier:@"ShowMainMenu" sender:indexPath];
}

-(void)addGesture{

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(touchesBegan)];
    [self.view addGestureRecognizer:tap];

}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self.tasksTableView deselectRowAtIndexPath:[self.tasksTableView indexPathForSelectedRow] animated:YES];
    
}

- (void)touchesBegan {

    _countTaps++;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *simpleTableIdentifier = @"SimpleTableItem";
    CompactViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[CompactViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.cellState = CELL_SHRINKED;
    [self configureMainCell:cell atIndexPath:indexPath];
    return cell;
}

-(void)configureMainCell:(CompactViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    
    Tasks *taskItem = [_fetchedResultsController objectAtIndexPath:indexPath];
    cell.theTitle.text = taskItem.taskTitle;
    [cell.priorityImage setImage:[UIImage imageNamed:@"home_screen_periorty!!_icon"]];
    [cell.starImage setImage:[UIImage imageNamed:@"home_screen_star_icon"]];
    cell.taskTime.text = taskItem.tastTime;
    cell.taskDate.text = taskItem.taskDate;
    cell.taskDueTime.text = taskItem.tastTime;
    cell.taskDueDate.text = taskItem.taskDate;
    cell.taskNote.text = taskItem.taskNote;
    [cell.actionOut setTitle:taskItem.taskAction forState:UIControlStateNormal];
    [cell.remindOut setTitle:taskItem.taskReminder forState:UIControlStateNormal];
    [cell.repeatOut setTitle:taskItem.taskRepeat forState:UIControlStateNormal];
        cell.remindOut.tag = indexPath.row;
    cell.actionOut.tag = indexPath.row;
    cell.repeatOut.tag=indexPath.row;
  
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id  sectionInfo =
    [[_fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath == _expandedCellIndexPath)
        return 320;
    else
        return 90;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if(_doubleClick == YES)
    [self performSegueWithIdentifier:@"ShowMainMenu" sender:indexPath];
    [self performSegueWithIdentifier:@"ShowMainMenu" sender:indexPath];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{  if ([[segue identifier] isEqualToString:@"ShowMainMenu"])
{
    DetailsViewController *transfer=segue.destinationViewController;
    NSIndexPath *indexPath=(NSIndexPath *)sender;
    Tasks *info = [_fetchedResultsController objectAtIndexPath:indexPath];
    transfer.taskTitle=info.taskTitle;
    transfer.taskDate=info.taskDate;
    transfer.taskTime= info.tastTime;
    transfer.taskAction=info.taskAction;
    transfer.taskRemind=info.taskReminder;
    transfer.taskRepeat=info.taskRepeat;
    transfer.taskNote=info.taskNote;
    
}
}

- (IBAction)expandCell:(id)sender {
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tasksTableView];
    NSIndexPath *indexPath = [self.tasksTableView indexPathForRowAtPoint:buttonPosition];
    CompactViewCell *cell = [self.tasksTableView cellForRowAtIndexPath:indexPath];
    if ([self isExpanded:cell.cellState]) {
        //shrink it
        cell.cellState = CELL_SHRINKED;
        _expandedCellIndexPath = nil;
        [UIView animateWithDuration:0.3 animations:^{
            [self.tasksTableView beginUpdates];
            [self shrinkWithAnimation:cell];
            [self.tasksTableView endUpdates];
        } completion:^(BOOL finished) {
            cell.expandView.hidden = YES;
        }];
    } else { //expand it
        cell.cellState = CELL_EXPANDED;
        _expandedCellIndexPath = indexPath;
        [UIView animateWithDuration:0.3 animations:^{
            [self.tasksTableView beginUpdates];
            [self expandWithAnimation:cell];
            [self.tasksTableView endUpdates];
        } completion:^(BOOL finished) {
        }];
    }
}

-(void)expandWithAnimation:(CompactViewCell*)cell
{
    cell.detailViewHeight.constant = 217;
    cell.expandView.hidden = NO;
    [cell.contentView layoutIfNeeded];
}
-(void)shrinkWithAnimation:(CompactViewCell*)cell
{
    cell.detailViewHeight.constant = 0;
    [cell.contentView layoutIfNeeded];
}
-(BOOL)isExpanded:(CellStatus)state
{
    return state == CELL_EXPANDED;
}

#pragma mark - fetchedResultsController

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:TASKS_ENTITY_NAME  inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    [fetchRequest setFetchBatchSize:20];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey:TASKS_COLUMN_ID ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    NSFetchedResultsController *theFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:managedObjectContext sectionNameKeyPath:nil
                                                   cacheName:nil];
    self.fetchedResultsController = theFetchedResultsController;
    _fetchedResultsController.delegate = self;
    return _fetchedResultsController;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tasksTableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tasksTableView;
    switch(type)
    {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeUpdate:
             [self configureMainCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray
                                               arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray
                                               arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type)
    {
            
        case NSFetchedResultsChangeInsert:
            [self.tasksTableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tasksTableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeMove:
            
            break;
        case NSFetchedResultsChangeUpdate:
            
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tasksTableView endUpdates];
}


@end
