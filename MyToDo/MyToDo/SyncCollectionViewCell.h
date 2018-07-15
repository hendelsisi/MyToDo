//
//  SyncCollectionViewCell.h
//  MyToDo
//
//  Created by hend elsisi on 4/19/16.
//  Copyright © 2016 hend elsisi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SyncCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *separator;
@property (weak, nonatomic) IBOutlet UIView *selectorView;
@property (weak, nonatomic) IBOutlet UILabel *folderOption;

@end
