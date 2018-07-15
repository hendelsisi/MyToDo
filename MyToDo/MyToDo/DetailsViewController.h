//
//  DetailsViewController.h
//  MyToDo
//
//  Created by hend elsisi on 3/29/16.
//  Copyright © 2016 hend elsisi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonPopUpViewController.h"
#import "TimePopUpViewController.h"
//#import "UIViewController+MaryPopin.h"
#import "PDTSimpleCalendarViewController.h"
#import "PDTSimpleCalendarViewCell.h"
#import "PDTSimpleCalendarViewHeader.h"
#import "CalendarPopUpViewController.h"

@interface DetailsViewController : UIViewController<CommonPopUpViewControllerDelegate,TimePopUpViewControllerDelegate,CalendarPopUpViewControllerDelegate>

@property NSString* taskNote;
@property NSString* taskTime;
@property NSString* taskDate;
@property NSString* taskRemind;
@property NSString* taskRepeat;
@property NSString* taskTitle;
@property NSString* taskAction;
@property (weak, nonatomic) IBOutlet UIButton *nonButton;
@property (weak, nonatomic) IBOutlet UITextField *titleText;
@property (weak, nonatomic) IBOutlet UITextView *textViewNote;
- (IBAction)setPriority:(id)sender;
- (IBAction)reminderAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *reminderValue;
- (IBAction)showRepeatOptions:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *actionValue;
@property (weak, nonatomic) IBOutlet UIButton *repeatValue;
- (IBAction)showAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *timeOutlet;
@property (weak, nonatomic) IBOutlet UIButton *dateOutlet;




@end
