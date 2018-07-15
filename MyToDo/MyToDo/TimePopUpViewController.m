//
//  TimePopUpViewController.m
//  MyToDo
//
//  Created by hend elsisi on 4/13/16.
//  Copyright © 2016 hend elsisi. All rights reserved.
//

#import "TimePopUpViewController.h"
#import "UIViewController+MaryPopin.h"
@interface TimePopUpViewController ()

@property NSString*hours;
@property NSString*minutes;
@property NSString*theNoon;
@property int hoursFromPreviousScene;
@property int minutesFromPreviousScene;
@property NSString* noonFromPreviousScene;
@property (weak, nonatomic) IBOutlet UIButton *hoursBeingSelected;
@property (weak, nonatomic) IBOutlet UIButton *minutesBeingSelected;
@property (weak, nonatomic) IBOutlet UIButton *noonChosenValue;
@property (weak, nonatomic) IBOutlet UIView *theView;
@property  ESTimePicker *timePicker;

@end

@implementation TimePopUpViewController
- (IBAction)chooseMinutes:(id)sender {
    [_timePicker setType: ESTimePickerTypeMinutes animated:YES];
    [ _minutesBeingSelected setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_noonChosenValue setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [ _hoursBeingSelected setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
}
- (IBAction)chooseHours:(id)sender {
    [_timePicker setType: ESTimePickerTypeHours animated:YES];
    [ _minutesBeingSelected setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_noonChosenValue setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [ _hoursBeingSelected setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self handleScreenRotation];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    timeFormatter.dateFormat = @"hh:mm a";
   [ _minutesBeingSelected setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_noonChosenValue setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     _timePicker = [[ESTimePicker alloc] initWithDelegate:self];
    _timePicker.delegate=self;
    if(_landscapeView == YES){
     [_timePicker setFrame:CGRectMake(0, 0, 200, 200)];
    }
    else{
     [_timePicker setFrame:CGRectMake(0, 0, 240, 260)];
    }
    if (_enteredTime.length == 0) {
        [_minutesBeingSelected setTitle:@": 59" forState:UIControlStateNormal];
        [_hoursBeingSelected setTitle:@"12" forState:UIControlStateNormal];
        _theNoon = @"AM";
        _hours = @"12";
        _minutes = @"59";
        _timePicker.hours=12;
        _timePicker.minutes=59;
    }
    else{
        [self getHoursAndMinutesAndNoon:_enteredTime];
        if ([_noonFromPreviousScene isEqualToString:@"PM"]) {
            _timePicker.startWithPmHighlighted = true;
            _theNoon = @"PM";
        }
        else{
              _theNoon = @"AM";
        }
        
        _timePicker.hours=_hoursFromPreviousScene;
        _timePicker.minutes=_minutesFromPreviousScene;
        _hours =  [@(_hoursFromPreviousScene) stringValue];;
        _minutes = [@(_minutesFromPreviousScene) stringValue];;
    
    }
    
    [self.theView addSubview:_timePicker];
    if(_timePicker.amButton.isSelected){
       [_noonChosenValue setTitle:@"AM" forState:UIControlStateNormal];
    }
    else if(_timePicker.pmButton.isSelected){
        [_noonChosenValue setTitle:@"PM" forState:UIControlStateNormal];
    }
 
}


-(void)getHoursAndMinutesAndNoon:(NSString*)time{
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    timeFormatter.dateFormat = @"hh:mm a";
    NSDate* date = [timeFormatter dateFromString:time];
    [timeFormatter setDateFormat:@"h"];
    NSString *currentHour = [timeFormatter stringFromDate: date];
    [timeFormatter setDateFormat:@"m"];
    NSString *currentMinute = [timeFormatter stringFromDate: date];
    [timeFormatter setDateFormat:@"a"];
    _noonFromPreviousScene = [timeFormatter stringFromDate: date];
    _hoursFromPreviousScene = [currentHour intValue];
    _minutesFromPreviousScene = [currentMinute intValue];
    [_hoursBeingSelected setTitle:currentHour forState:UIControlStateNormal];
    [_minutesBeingSelected setTitle:[@": " stringByAppendingString:currentMinute] forState:UIControlStateNormal];
    if ([_noonFromPreviousScene isEqualToString:@"PM"]) {
        _theNoon = @"PM";
    }
    else{
         _theNoon = @"AM";
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)confirmTime:(id)sender {
    NSString* selectedTime =[ _hours stringByAppendingString:@":"];
    selectedTime = [selectedTime stringByAppendingString:_minutes];
    selectedTime = [selectedTime stringByAppendingString:@" "];
    selectedTime = [selectedTime stringByAppendingString:_theNoon];
    [self.delegate TimePopUpViewControllerDelegateDidHide:selectedTime];
    [self.parentViewController dismissCurrentPopinControllerAnimated:YES];
}
- (IBAction)cancelTime:(id)sender {
    [self.parentViewController dismissCurrentPopinControllerAnimated:YES];
}

#pragma mark - ESTimePicker

- (void)timePickerHoursChanged:(ESTimePicker *)timePicker toHours:(int)hours
{
    [_noonChosenValue setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [ _minutesBeingSelected setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [ _hoursBeingSelected setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
  
    if (hours < 10) {
        _hours = @"0";
        _hours = [_hours stringByAppendingString:[NSString stringWithFormat:@"%i", hours]];
    }
    else{
        _hours = [NSString stringWithFormat:@"%i", hours];
    }
      [_hoursBeingSelected setTitle:_hours  forState:UIControlStateNormal];
}

- (void)timePickerMinutesChanged:(ESTimePicker *)timePicker toMinutes:(int)minutes
{
    if (minutes < 10) {
        _minutes = @"0";
         _minutes = [_minutes stringByAppendingString:[NSString stringWithFormat:@"%i", minutes]];
    }
    else{
    
        _minutes = [NSString stringWithFormat:@"%i", minutes];
    }
     NSString *minuteValue = [@": " stringByAppendingString:_minutes];
    [_minutesBeingSelected setTitle:minuteValue forState:UIControlStateNormal];
    
}
-(void)amIsSelected:(ESTimePicker *)timePicker{

    [_noonChosenValue setTitle:@"AM" forState:UIControlStateNormal];
    _theNoon = @"AM";
    [_noonChosenValue setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [ _minutesBeingSelected setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
}
-(void)pmIsSelected:(ESTimePicker *)timePicker{

 [_noonChosenValue setTitle:@"PM" forState:UIControlStateNormal];
 _theNoon = @"PM";
    [_noonChosenValue setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [ _minutesBeingSelected setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
}
-(void)handleScreenRotation{
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(orientationChanged:)
     name:UIDeviceOrientationDidChangeNotification
     object:[UIDevice currentDevice]];
}

- (void) orientationChanged:(NSNotification *)note
{
    UIDevice * device = note.object;
    switch(device.orientation)
    {
        case UIDeviceOrientationPortrait:
            /* start special animation */
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            /* start special animation */
            break;
        case UIDeviceOrientationLandscapeLeft:
            self.view.bounds = CGRectMake(0, 0, 450, 220);
            break;
        case UIDeviceOrientationFaceDown:
            break;
        case UIDeviceOrientationUnknown:
            break;
        case UIDeviceOrientationFaceUp:
            break;
        case UIDeviceOrientationLandscapeRight:
            //  self.view.bounds = CGRectMake(0, 0, 100, 100);
            break;
        default:
            break;
    };
}


@end
