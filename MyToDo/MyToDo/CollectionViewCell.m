//
//  CollectionViewCell.m
//  MyToDo
//
//  Created by hend elsisi on 4/19/16.
//  Copyright © 2016 hend elsisi. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    UIView* view =[[UIView alloc]initWithFrame:self.bounds];
    self.selectedBackgroundView = view;
    self.selectedBackgroundView.layer.borderWidth = 1;
    self.selectedBackgroundView.layer.borderColor = [UIColor blackColor].CGColor;
    
}

@end
