//
//  SettingViewController.m
//  MyToDo
//
//  Created by hend elsisi on 4/16/16.
//  Copyright © 2016 hend elsisi. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()
{
    VSDropdown *_dropdown;
}
typedef enum {
    ENABLED = 0,
    DISABLED
} NotificationState;
@property (weak, nonatomic) IBOutlet UIButton *snoozeValue;
@property  NSMutableArray *array;
@property NSString* currentPassword;
@property BOOL editBegins;
@property NSString* preparedPasswordForTheSecondEditing;
@property (weak, nonatomic) IBOutlet UIButton *notifyIndicator;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property NotificationState notifyState;
@end

@implementation SettingViewController

- (IBAction)notification:(id)sender {
    if (_notifyState == ENABLED) {
        _notifyState = DISABLED;
        [_notifyIndicator setImage:[UIImage imageNamed:@"acount_screen_off_icon"] forState:UIControlStateNormal];
    } else {
        _notifyState = ENABLED;
        [_notifyIndicator setImage:[UIImage imageNamed:@"acount_screen_on_icon"] forState:UIControlStateNormal];
    }
}
- (IBAction)deletePassword:(id)sender {
    _passwordField.text = @"";
    _preparedPasswordForTheSecondEditing = @"";
}
- (IBAction)logOut:(id)sender {
    //pop
     [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)logOutCalendar:(id)sender {
    //pop
     [self.navigationController popViewControllerAnimated:YES];
}

-(void)textFieldDidChange :(UITextField *)theTextField{
    _currentPassword = theTextField.text;
    if (_editBegins == YES) {
        theTextField.text = [_preparedPasswordForTheSecondEditing stringByAppendingString:_currentPassword];
        _editBegins = NO;
    }
    NSLog(@"entered till now : %@",_currentPassword);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
   // _passwordField.text = _currentPassword;
    NSLog(@"jkbb");
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    _editBegins = YES;
    _preparedPasswordForTheSecondEditing = _currentPassword;
    NSLog(@"jkbb");
}


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
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
      [self createDoneButton];
        _notifyState = DISABLED;
    [_passwordField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    _dropdown = [[VSDropdown alloc]initWithDelegate:self];
    [_dropdown setAdoptParentTheme:YES];
    [_dropdown setShouldSortItems:YES];
      }

-(void)updateButtonLayers
{
    [self.snoozeValue.layer setCornerRadius:3.0];
    [self.snoozeValue.layer setBorderWidth:1.0];
    [self.snoozeValue.layer setBorderColor:[self.snoozeValue.titleLabel.textColor CGColor]];
}

- (IBAction)snoozeOptionsPressed:(id)sender {
    [self showDropDownForButton:sender adContents:@[@"5 mins",@"10 mins",@"15 mins",@"20 mins"] multipleSelection:NO];
}

-(void)showDropDownForButton:(UIButton *)sender adContents:(NSArray *)contents multipleSelection:(BOOL)multipleSelection
{
    [_dropdown setDrodownAnimation:rand()%2];
    [_dropdown setAllowMultipleSelection:multipleSelection];
    [_dropdown setupDropdownForView:sender];
    [_dropdown setSeparatorColor:sender.titleLabel.textColor];
    if (_dropdown.allowMultipleSelection)
    {
        [_dropdown reloadDropdownWithContents:contents andSelectedItems:[[sender titleForState:UIControlStateNormal] componentsSeparatedByString:@";"]];
    }
    else
    {
    [_dropdown reloadDropdownWithContents:contents andSelectedItems:@[[sender titleForState:UIControlStateNormal]]];
    }
}

#pragma mark -
#pragma mark - VSDropdown Delegate methods.
- (void)dropdown:(VSDropdown *)dropDown didChangeSelectionForValue:(NSString *)str atIndex:(NSUInteger)index selected:(BOOL)selected
{
    UIButton *btn = (UIButton *)dropDown.dropDownView;
    
    NSString *allSelectedItems = nil;
    if (dropDown.selectedItems.count > 1)
    {
        allSelectedItems = [dropDown.selectedItems componentsJoinedByString:@";"];
    }
    else
    {
        allSelectedItems = [dropDown.selectedItems firstObject];
    }
    [btn setTitle:allSelectedItems forState:UIControlStateNormal];
}

- (UIColor *)outlineColorForDropdown:(VSDropdown *)dropdown
{
    UIButton *btn = (UIButton *)dropdown.dropDownView;
    return btn.titleLabel.textColor;
}

- (CGFloat)outlineWidthForDropdown:(VSDropdown *)dropdown
{
    return 2.0;
}

- (CGFloat)cornerRadiusForDropdown:(VSDropdown *)dropdown
{
    return 3.0;
}

- (CGFloat)offsetForDropdown:(VSDropdown *)dropdown
{
    return -2.0;
}
@end
