//
//  CalendarPopUpViewController.h
//  MyToDo
//
//  Created by hend elsisi on 4/13/16.
//  Copyright © 2016 hend elsisi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PDTSimpleCalendarViewController.h"
#import "PDTSimpleCalendarViewCell.h"
#import "PDTSimpleCalendarViewHeader.h"

@protocol CalendarPopUpViewControllerDelegate;

@interface CalendarPopUpViewController : UIViewController<PDTSimpleCalendarViewDelegate>

@property (nonatomic, strong) id<CalendarPopUpViewControllerDelegate> delegate;
@property NSString *previousSelectedValueFromThePreviousScene;
@property (nonatomic, strong) NSArray *customDates;
@property (weak, nonatomic) IBOutlet UILabel *selectedDateDay;
@property (weak, nonatomic) IBOutlet UILabel *selectedDateMonth;
@property (weak, nonatomic) IBOutlet UILabel *selectedDateYear;
@property (weak, nonatomic) IBOutlet UILabel *selectedDateDayNumber;

@end

@protocol CalendarPopUpViewControllerDelegate
-(void)calendarPopUpViewControllerDelegateDidHide:(NSString*)selectedItem;
@end
