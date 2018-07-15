//
//  DetailsViewController.m
//  MyToDo
//
//  Created by hend elsisi on 3/29/16.
//  Copyright © 2016 hend elsisi. All rights reserved.
//

#import "DetailsViewController.h"
#import "IQKeyboardManager.h"
#import "AppDelegate.h"
#import "Tasks.h"
#import "Header.h"
#import "TimePopUpViewController.h"
#import "TLTagsControl.h"
#import "ToDoItem.h"
#import "DataBaseManager.h"

@interface DetailsViewController ()


@property int previousPriorityButton;
@property NSString* initialTaskTitle;
@property (weak, nonatomic) IBOutlet TLTagsControl *tasksTags;

@end
@implementation DetailsViewController

- (IBAction)chooseTime:(id)sender {
     [[self navigationController] setNavigationBarHidden:YES animated:YES];
    TimePopUpViewController *popin = (TimePopUpViewController*)[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"TimePopUp"];
    popin.delegate=self;
    popin.enteredTime = _taskTime;
    if ([self isLandScapeView]) {
        popin.landscapeView = YES;
        popin.view.bounds = CGRectMake(0, 0, 500, 270);
    }
    else
    { popin.view.bounds = CGRectMake(0, 0, 250, 400);
    }
    [self presentPopinController:popin animated:YES completion:^{
        NSLog(@"Popin presented !");
        
    }];
}
-(BOOL)isLandScapeView{
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
        return orientation == UIInterfaceOrientationLandscapeLeft ||
    orientation == UIInterfaceOrientationLandscapeRight;
}

- (IBAction)chooseDate:(id)sender {
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    CalendarPopUpViewController *popin = (CalendarPopUpViewController*)[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DatePopUp"];
    popin.delegate=self;
    popin.previousSelectedValueFromThePreviousScene = _taskDate;
    popin.view.bounds = CGRectMake(0, 0, 600, 600);
    [self presentPopinController:popin animated:YES completion:^{
        NSLog(@"Popin presented !");
    }];
}


-(void)storeData
{
    ToDoItem *taskItem=[[ToDoItem alloc]init];
    [taskItem setTaskTitle:_taskTitle];
    [taskItem setTaskTime:_taskTime];
    [taskItem setTaskRepeat:_taskRepeat];
    [taskItem setTaskReminder:_taskRemind];
    [taskItem setTaskNote:_taskNote];
    [taskItem setTaskDate:_taskDate];
    [taskItem setTaskAction:_taskAction];
    DataBaseManager *database=[[DataBaseManager alloc]init];
        if ([self addNewTask]) {
            [database storeNewTask:taskItem];
        } else {
            [database editTask:_initialTaskTitle andToDoItem:taskItem];
        }
}

-(BOOL)addNewTask{
    return _initialTaskTitle.length == 0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
 }

-(void)initData{
    _previousPriorityButton=106;
    [[_nonButton layer] setBorderWidth:1.0f];
    [[_nonButton layer] setBorderColor:[UIColor lightGrayColor].CGColor];
    [self createDoneButton];
    [_actionValue setTitle:_taskAction forState:UIControlStateNormal];
    [_repeatValue setTitle:_taskRepeat forState:UIControlStateNormal];
    [_timeOutlet setTitle:_taskTime forState:UIControlStateNormal];
    [_reminderValue setTitle:_taskRemind forState:UIControlStateNormal];
    [_dateOutlet setTitle:_taskDate forState:UIControlStateNormal];
    _titleText.text=_taskTitle;
    [_titleText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_textViewNote setText:_taskNote];
    _initialTaskTitle = _taskTitle;
}


- (void)textViewDidChange:(UITextView *)textView{
       _taskNote=textView.text;
}


#pragma Done Button
-(void)createDoneButton{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"details_screen_accept_icon"] forState:UIControlStateNormal];
    [self.view addSubview:button];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint * c_1 =[NSLayoutConstraint constraintWithItem:self.view
                                                           attribute:NSLayoutAttributeTrailing
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:button
                                                           attribute:NSLayoutAttributeTrailing
                                                          multiplier:1.0 constant:5];
    NSLayoutConstraint * c_2 =[NSLayoutConstraint constraintWithItem:self.view
                                                           attribute:NSLayoutAttributeBottom
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:button
                                                           attribute:NSLayoutAttributeBottom
                                                          multiplier:1.0 constant:10];
    NSLayoutConstraint * equal_w = [NSLayoutConstraint constraintWithItem:button
                                                                attribute:NSLayoutAttributeWidth
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:nil
                                                                attribute:0
                                                               multiplier:1.0
                                                                 constant:100];
    NSLayoutConstraint * equal_h = [NSLayoutConstraint constraintWithItem:button
                                                                attribute:NSLayoutAttributeHeight
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:nil
                                                                attribute:0
                                                               multiplier:1.0
                                                                 constant:100];
    [self.view addConstraints:@[c_1,c_2]];
    [button addConstraints:@[equal_w,equal_h]];
    [button addTarget:self action:@selector (acceptButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void) acceptButtonPressed
{
    if( ![self emptyTaskTitle]){
        [self.navigationController popViewControllerAnimated:YES];
        [self storeData];
    }
    else{
        [self showAlert];
    }
}
-(void)showAlert{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle: @""
                                                                        message: @"You should Enter Text Title"
                                                                 preferredStyle: UIAlertControllerStyleAlert];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle: @"OK"
                                                          style: UIAlertActionStyleDestructive
                                                        handler: ^(UIAlertAction *action) {
                                                            
                                                        }];
    [controller addAction: alertAction];
    [self presentViewController:controller animated:YES completion:nil];
}

-(BOOL)emptyTaskTitle{
    return _titleText.text.length == 0;
}

- (IBAction)showRepeatOptions:(id)sender {
    AppDelegate *appdelegate;
    appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appdelegate setTarget:REPEAT_POPUP];
      CommonPopUpViewController *popin = (CommonPopUpViewController*)[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CommonPopUp"];
    popin.delegate = self;
    popin.previousSelectedValueFromThePreviousScene = _taskRepeat;
    if ([_taskRepeat isEqualToString:@"No Repeat"]) {
        popin.deactivateCell = YES;
    }
    popin.view.bounds = CGRectMake(0, 0, 400, 300);
    [self presentPopinController:popin animated:YES completion:^{
    }];
 }

- (IBAction)showAction:(id)sender
{
    AppDelegate *appdelegate;
    appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appdelegate setTarget:ACTION_POPUP];
    CommonPopUpViewController *popin = (CommonPopUpViewController*)[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CommonPopUp"];
    popin.delegate = self;
    popin.previousSelectedValueFromThePreviousScene = _taskAction;
    if ([_taskAction isEqualToString:@"No Action"]) {
        popin.deactivateCell = YES;
    }
    popin.view.bounds = CGRectMake(0, 0, 400, 300);
    [self presentPopinController:popin animated:YES completion:^{
        NSLog(@"Popin presented !");
    }];
}

- (IBAction)reminderAction:(id)sender {
    AppDelegate *appdelegate;
    appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appdelegate setTarget:REMINDER_POPUP];
    CommonPopUpViewController *popin = (CommonPopUpViewController*)[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CommonPopUp"];
    popin.delegate=self;
    popin.previousSelectedValueFromThePreviousScene = _taskRemind;
    if ([_taskRemind isEqualToString:@"No Reminder"]) {
        popin.deactivateCell = YES;
    }
    popin.view.bounds = CGRectMake(0, 0, 400, 300);
    [self presentPopinController:popin animated:YES completion:^{
        NSLog(@"Popin presented !");
    }];
}


-(void)textFieldDidChange :(UITextField *)theTextField{
    _taskTitle=theTextField.text;
}

- (IBAction)setPriority:(id)sender {
    UIButton *but = (UIButton *)[self.view viewWithTag:_previousPriorityButton];
    [[but layer] setBorderWidth:0];
    UIButton* button=(UIButton*)sender;
    [[button layer] setBorderWidth:1.0f];
    [[button layer] setBorderColor:[UIColor lightGrayColor].CGColor];
    _previousPriorityButton=(int)button.tag;
}


#pragma mark: CommonPopUpViewControllerDelegate
-(void)CommonPopUpViewControllerDelegateDidHide:(NSString*)selectedItem
{
    TargetToSelect target=[(AppDelegate *)[[UIApplication sharedApplication] delegate] target];
    if (target == REPEAT_POPUP) {
        [_repeatValue setTitle:selectedItem forState:UIControlStateNormal];
        _taskRepeat = selectedItem;
        
    } else if(target == REMINDER_POPUP){
        [_reminderValue setTitle:selectedItem forState:UIControlStateNormal];
        _taskRemind = selectedItem;
    }
    else{
        [_actionValue setTitle:selectedItem forState:UIControlStateNormal];
       _taskAction = selectedItem;
  
    }

}
#pragma mark: CalendarPopUpViewControllerDelegate
-(void)calendarPopUpViewControllerDelegateDidHide:(NSString*)selectedItem
{
    _taskDate = selectedItem;
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    [_dateOutlet setTitle:selectedItem forState:UIControlStateNormal];
}
#pragma mark: TimePopUpViewControllerDelegate
-(void)TimePopUpViewControllerDelegateDidHide:(NSString*)selectedItem
{
     [[self navigationController] setNavigationBarHidden:NO animated:YES];
    [_timeOutlet setTitle:selectedItem forState:UIControlStateNormal];
    _taskTime = selectedItem;
    
}

@end
