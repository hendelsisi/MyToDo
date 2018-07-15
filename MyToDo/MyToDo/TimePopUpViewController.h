//
//  TimePopUpViewController.h
//  MyToDo
//
//  Created by hend elsisi on 4/13/16.
//  Copyright © 2016 hend elsisi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESTimePicker.h"
@protocol TimePopUpViewControllerDelegate;

@interface TimePopUpViewController : UIViewController<ESTimePickerDelegate>
@property NSString* enteredTime;
@property (nonatomic, strong) id<TimePopUpViewControllerDelegate> delegate;
@property NSString *previousSelectedValueFromThePreviousScene;
@property BOOL landscapeView;
@end

@protocol TimePopUpViewControllerDelegate
  -(void)TimePopUpViewControllerDelegateDidHide:(NSString*)selectedItem;
@end