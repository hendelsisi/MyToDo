//
//  CalendarPopUpViewController.m
//  MyToDo
//
//  Created by hend elsisi on 4/13/16.
//  Copyright © 2016 hend elsisi. All rights reserved.
//

#import "CalendarPopUpViewController.h"
#import "UIViewController+MaryPopin.h"
@interface CalendarPopUpViewController ()
@property (weak, nonatomic) IBOutlet UIView *container;
@property NSString *currentUserSelectedDate;

@end

@implementation CalendarPopUpViewController

- (IBAction)confirmDateSelection:(id)sender {
    [self.parentViewController dismissCurrentPopinControllerAnimated:YES];
    [self.delegate calendarPopUpViewControllerDelegateDidHide:_currentUserSelectedDate];    
}
- (IBAction)cancelDateSelection:(id)sender {
    [self.parentViewController dismissCurrentPopinControllerAnimated:YES];
    [self.delegate calendarPopUpViewControllerDelegateDidHide:_currentUserSelectedDate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDate* initialDate;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    PDTSimpleCalendarViewController *calendarViewController = [[PDTSimpleCalendarViewController alloc] init];
    [calendarViewController setDelegate:self];
    calendarViewController.weekdayHeaderEnabled = YES;
    calendarViewController.weekdayTextType = PDTSimpleCalendarViewWeekdayTextTypeVeryShort;
   
    if (_previousSelectedValueFromThePreviousScene.length == 0) {
         calendarViewController.firstDate = [NSDate date];
         initialDate = [NSDate date];
        _currentUserSelectedDate = @"";
        NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
        offsetComponents.month = 6;
        NSDate *lastDate =[calendarViewController.calendar dateByAddingComponents:offsetComponents toDate:[NSDate date] options:0];
        calendarViewController.lastDate = lastDate;
        }
    else{
        [dateFormatter setDateFormat:@"dd MMM yyyy"];
        initialDate = [dateFormatter dateFromString:_previousSelectedValueFromThePreviousScene];
        [dateFormatter setDateFormat:@"dd/mm/yyyy"];
        calendarViewController.firstDate = [dateFormatter dateFromString:[@"01/01/" stringByAppendingString:_selectedDateYear.text]];
        calendarViewController.previouseSelectedDateFromUserfromThePreviousScene = initialDate;
        [dateFormatter setDateFormat:@"dd MMM yyy"];
        _currentUserSelectedDate =  [dateFormatter stringFromDate:initialDate];
        NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
        offsetComponents.month = 12;
        NSDate *lastDate =[calendarViewController.calendar dateByAddingComponents:offsetComponents toDate:[NSDate date] options:0];
        calendarViewController.lastDate = lastDate;
    }
    [dateFormatter setDateFormat:@"yyyy"];
    _selectedDateYear.text = [dateFormatter stringFromDate:initialDate];
    [dateFormatter setDateFormat:@"MMM"];
    _selectedDateMonth.text = [dateFormatter stringFromDate:initialDate];
    [dateFormatter setDateFormat:@"EEEE"];
    _selectedDateDay.text = [dateFormatter stringFromDate:initialDate];
    [dateFormatter setDateFormat:@"dd"];
    _selectedDateDayNumber.text = [dateFormatter stringFromDate:initialDate];
    calendarViewController.view.frame = self.container.bounds;
    [self addChildViewController:calendarViewController];
    [self.container addSubview:calendarViewController.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PDTSimpleCalendarViewDelegate

- (void)simpleCalendarViewController:(PDTSimpleCalendarViewController *)controller didSelectDate:(NSDate *)date
{
   [self storeStringDate:date];
}

- (BOOL)simpleCalendarViewController:(PDTSimpleCalendarViewController *)controller shouldUseCustomColorsForDate:(NSDate *)date
{
    if ([self.customDates containsObject:date]) {
        return YES;
    }
    
    return NO;
}

- (UIColor *)simpleCalendarViewController:(PDTSimpleCalendarViewController *)controller circleColorForDate:(NSDate *)date
{
    return [UIColor whiteColor];
}

- (UIColor *)simpleCalendarViewController:(PDTSimpleCalendarViewController *)controller textColorForDate:(NSDate *)date
{
    return [UIColor orangeColor];
}


-(NSString*)storeStringDate:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy"];
    _selectedDateYear.text = [dateFormatter stringFromDate:date];
     [dateFormatter setDateFormat:@"MMM"];
     _selectedDateMonth.text = [dateFormatter stringFromDate:date];
    [dateFormatter setDateFormat:@"EEEE"];
     _selectedDateDay.text = [dateFormatter stringFromDate:date];
    [dateFormatter setDateFormat:@"dd"];
    _selectedDateDayNumber.text = [dateFormatter stringFromDate:date];
    [dateFormatter setDateFormat:@"dd MMM yyyy"];
    _currentUserSelectedDate = [dateFormatter stringFromDate:date];
     [dateFormatter setDateFormat:@"yyyy-MMM-EEEE"];
    return [dateFormatter stringFromDate:date];
 }


@end
