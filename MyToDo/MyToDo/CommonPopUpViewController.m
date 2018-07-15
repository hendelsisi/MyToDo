//
//  ReminderViewController.m
//  MyToDo
//
//  Created by hend elsisi on 4/13/16.
//  Copyright © 2016 hend elsisi. All rights reserved.
//

#import "CommonPopUpViewController.h"
#import "Header.h"
#import "HexColors.h"
#import "AppDelegate.h"

@interface CommonPopUpViewController ()
@property (weak, nonatomic) IBOutlet UILabel *popUpTitle;
@property int numberOfItems;
@property TargetToSelect detectSource;
@property int selectedCellIndex;
@property NSString* selectedCellValue;
@property int previousSelectedCellIndex;
@property UIButton* previousSelectedbutton;
@property UIButton* currentSelectedbutton;
@property BOOL isInitialView;
@property BOOL modifyTask;
typedef enum {
    SET_HILIGHT = 0,
    REMOVE_HILIGHT
} SelectState;

typedef enum {
    ON_STATE = 0,
    OFF_STATE
} SwitchState;
@property (weak, nonatomic) IBOutlet UIButton *switchButton;
@property SwitchState activeCell;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation CommonPopUpViewController
- (IBAction)swithCellActive:(id)sender {
    if(_activeCell == ON_STATE )
    {
        _activeCell = OFF_STATE;
        UIButton *button = (UIButton*)sender;
        [button setTitle:@"OFF" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"popUp_screen_off_icon"] forState:UIControlStateNormal];
    }
    else
    {
      _activeCell = ON_STATE;
        UIButton *button = (UIButton*)sender;
        _modifyTask = NO;
        [button setImage:[UIImage imageNamed:@"popUp_screen_on_icon"] forState:UIControlStateNormal];
    }
    _deactivateCell = NO;
    [_collectionView reloadData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    if (_deactivateCell == YES) {
    [_switchButton setImage:[UIImage imageNamed:@"popUp_screen_off_icon"] forState:UIControlStateNormal];
       }
    [self handleScreenRotation];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (_deactivateCell == YES) {
        _activeCell = OFF_STATE;
    }
  if(_previousSelectedValueFromThePreviousScene.length > 0)
  {
      _modifyTask = YES;
  }
  else{
      _modifyTask = NO;
  }
    _activeCell = ON_STATE;
    UINib *cellNib = [UINib nibWithNibName:@"Cell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"Cell"];
    _previousSelectedbutton=nil;
    _selectedCellIndex=0;
    _isInitialView=YES;
    _dataArray=[[NSMutableArray alloc]init];
    _detectSource =[(AppDelegate *)[[UIApplication sharedApplication] delegate] target];
    
  if(_detectSource == REMINDER_POPUP){
      _numberOfItems = 8;
        [_dataArray addObject:@"ON DUE" ];
        [_dataArray addObject:@"1 MIN" ];
        [_dataArray addObject:@"15 MIN" ];
        [_dataArray addObject:@"30 MIN" ];
        [_dataArray addObject:@"45 MIN" ];
        [_dataArray addObject:@"1 HR" ];
        [_dataArray addObject:@"1.5 HR" ];
        [_dataArray addObject:@"2 HR" ];
      
    _popUpTitle.text=@"Reminder";
    
    }
    else if(_detectSource == ACTION_POPUP){
         _numberOfItems = 5;
        [_dataArray addObject:@"CALL" ];
        [_dataArray addObject:@"EMAIL" ];
        [_dataArray addObject:@"SMS" ];
        [_dataArray addObject:@"LOCATION" ];
        [_dataArray addObject:@"WEBSITE" ];
    _popUpTitle.text=@"Task Action";
    }
    else{
         _numberOfItems = 5;
        [_dataArray addObject:@"HOURLY" ];
        [_dataArray addObject:@"DAILY" ];
        [_dataArray addObject:@"WEEKLY" ];
        [_dataArray addObject:@"MONTHLY" ];
        [_dataArray addObject:@"YEARLY" ];
        _popUpTitle.text=@"Task Repeated";
    
    }
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _numberOfItems; }

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    UIButton *cellButton=[self createButtonCells:(int)indexPath.item];
    UIView *view = (UIView *)[cell viewWithTag:100];
    
    [view addSubview:cellButton];
    if([self shouldBeActive])
    {
        [self activateCell:cellButton];
        if ([self istheDefaultChoise:cellButton] && _isInitialView == YES) {
            [self hilightCurrentCell:cellButton];
            _previousSelectedbutton = cellButton;
            _selectedCellValue = cellButton.titleLabel.text;
            _selectedCellIndex = (int)cellButton.tag;
        }
        else if ([self isCurrentSelectedCell:cellButton] && _isInitialView == NO){
            _previousSelectedbutton = cellButton;
        [self hilightCurrentCell:cellButton];
        
        }
        
        else {
            [self setCellColor:cellButton];
        }
    
    }
    else{
         [self deactivateButton:cellButton];
    }
    
        return cell;
}

-(void)activateCell:(UIButton*)button
{
  
    [[button layer] setBorderColor:[UIColor hx_colorWithHexRGBAString:@"#5856D6"].CGColor];
    [button addTarget:self action:@selector(selectEvent:) forControlEvents:UIControlEventTouchUpInside];
}
-(Boolean)isCurrentSelectedCell:(UIButton*)button{
    return button.tag == _selectedCellIndex;
}

-(Boolean)istheDefaultChoise:(UIButton*)button{
    if (_modifyTask == YES)
        return [_dataArray[button.tag] isEqualToString:_previousSelectedValueFromThePreviousScene];
    else
        return button.tag == 0 ;
}

-(void)deactivateButton:(UIButton*)button{
    [self removeHighlight:button];
    [[button layer] setBorderColor:[UIColor lightGrayColor].CGColor];
    [button setEnabled:NO];
}

-(UIButton*)createButtonCells:(int)index
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTag:index];
    [button setTitle:_dataArray[index] forState:UIControlStateNormal];
    button.frame = CGRectMake(1, 1, 79, 79);
    button.layer.cornerRadius = 38.5;
    [[button layer] setBorderWidth:1];
    button.titleLabel.font=[UIFont systemFontOfSize:15];
    return button;
}


-(Boolean)shouldBeActive{
    return _activeCell == ON_STATE && _deactivateCell != YES;
}
-(void)selectEvent:(UIButton*)btn{
    if(_activeCell == ON_STATE){
        
        _isInitialView = NO;
        [self removeHighlight:_previousSelectedbutton];
        _previousSelectedbutton=btn;
        _selectedCellIndex=(int)btn.tag;
        [self hilightCurrentCell:btn];
        _selectedCellValue = btn.titleLabel.text;
    
    }
}
-(void)hilightCurrentCell:(UIButton*)button{

    button.layer.backgroundColor=[UIColor hx_colorWithHexRGBAString:@"#5856D6"].CGColor;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

}

-(void)removeHighlight:(UIButton*)button{

    button.layer.backgroundColor=[UIColor whiteColor].CGColor;
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
}

-(void)setCellColor:(UIButton*)button{
    
    button.layer.backgroundColor=[UIColor whiteColor].CGColor;
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)confirmSelection:(id)sender {
    if ( _deactivateCell == YES || _activeCell == OFF_STATE) {
        switch (_detectSource) {
            case REMINDER_POPUP:
                _selectedCellValue = @"No Reminder";
                break;
                case REPEAT_POPUP:
                _selectedCellValue = @"No Repeat";
                break;
                
                case ACTION_POPUP:
                _selectedCellValue = @"No Action";
                break;
            default:
                break;
        }
       
    }
    
    [self.delegate CommonPopUpViewControllerDelegateDidHide:_selectedCellValue];
      [self.parentViewController dismissCurrentPopinControllerAnimated:YES];
    }
- (IBAction)cancelSelection:(id)sender {
   // [self.delegate CommonPopUpViewControllerDelegateDidHide:_selectedCellValue];
    
    [self.parentViewController dismissCurrentPopinControllerAnimated:YES];
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
