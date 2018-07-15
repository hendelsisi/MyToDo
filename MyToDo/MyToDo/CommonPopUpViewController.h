//
//  ReminderViewController.h
//  MyToDo
//
//  Created by hend elsisi on 4/13/16.
//  Copyright © 2016 hend elsisi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+MaryPopin.h"
@protocol CommonPopUpViewControllerDelegate;

@interface CommonPopUpViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) id<CommonPopUpViewControllerDelegate> delegate;
@property NSString *previousSelectedValueFromThePreviousScene;
@property BOOL deactivateCell;
@end
@protocol CommonPopUpViewControllerDelegate
-(void)CommonPopUpViewControllerDelegateDidHide:(NSString*)selectedItem;
@end