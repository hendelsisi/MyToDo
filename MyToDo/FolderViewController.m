//
//  FolderViewController.m
//  MyToDo
//
//  Created by hend elsisi on 4/19/16.
//  Copyright © 2016 hend elsisi. All rights reserved.
//

#import "FolderViewController.h"
#import "CollectionViewCell.h"
#import "SyncCollectionViewCell.h"
@interface FolderViewController ()
@property  NSMutableArray* colorArray;
@property NSMutableArray* selectedFolderOptions;
@property int arrayIndex;
@property NSMutableArray* folderOptions;
@end

@implementation FolderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _selectedFolderOptions = [[NSMutableArray alloc]init];
    _folderOptions = [[NSMutableArray alloc]init];
    [_folderOptions addObject:@"Show in all"];
    [_folderOptions addObject:@"    Sync"];
    [_folderOptions addObject:@"Protected"];
    [self createDoneButton];
    UINib *cellNib = [UINib nibWithNibName:@"CollectionViewCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"Cell"];
    UINib *cellNibFolder = [UINib nibWithNibName:@"SyncCollectionViewCell" bundle:nil];
    [self.folderType registerNib:cellNibFolder forCellWithReuseIdentifier:@"Cell"];
    _colorArray=[[NSMutableArray alloc]init];
    // Do any additional setup after loading the view.
    for (int i=0; i<20; i++) {
        CGFloat red = arc4random() % 255;
        CGFloat green = arc4random() % 255;
        CGFloat blue = arc4random() % 255;
        UIColor *color = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0f];
        [_colorArray addObject:color];
    }
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark:UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section
{
    if(collectionView == self.collectionView)
       return 20;
    else
        return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.collectionView) {
        CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
        cell.colorView.backgroundColor = _colorArray[indexPath.item];
        return cell;
    } else {
        SyncCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
        cell.tag = indexPath.item;
        cell.folderOption.text = _folderOptions[indexPath.item];
        return cell;
    }
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
        NSLog(@"werwqef");
        SyncCollectionViewCell *cell = (SyncCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (collectionView == _folderType) {
        if ([self isSelected:(NSInteger)cell.tag]) {
            cell.selectorView.layer.backgroundColor = [UIColor whiteColor].CGColor;
            [_selectedFolderOptions removeObjectAtIndex:_arrayIndex];
        }
        else{
         cell.selectorView.layer.backgroundColor = [UIColor lightGrayColor].CGColor;
            [_selectedFolderOptions addObject:[NSNumber numberWithInt:(int)cell.tag]];
        }
   }
}


-(BOOL)isSelected:(NSInteger)selectedIndex{
    BOOL selected = NO;
    for (int i = 0; i< _selectedFolderOptions.count; i++) {
                    if (selectedIndex == [_selectedFolderOptions[i] integerValue]) {
                        selected = YES;
                        _arrayIndex = i;
                        break;
                        //cell.selectorView.backgroundColor = [UIColor lightGrayColor];
                    }
                }

    return selected;
}

- (void) acceptButtonPressed
{
     [self.navigationController popViewControllerAnimated:YES];
    
}
@end
