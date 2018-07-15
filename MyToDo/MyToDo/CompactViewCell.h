//
//  TableViewCell.h
//  MyToDo
//
//  Created by hend elsisi on 3/29/16.
//  Copyright © 2016 hend elsisi. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    CELL_EXPANDED = 0,
    CELL_SHRINKED
    
} CellStatus;

@interface CompactViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextView *taskNote;
@property (weak, nonatomic) IBOutlet UILabel *theTitle;
@property CellStatus cellState;
@property (weak, nonatomic) IBOutlet UIView *expandView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailViewHeight;
@property (weak, nonatomic) IBOutlet UIImageView *starImage;
@property (weak, nonatomic) IBOutlet UIImageView *priorityImage;
@property (weak, nonatomic) IBOutlet UIButton *remindOut;
@property (weak, nonatomic) IBOutlet UIButton *repeatOut;
@property (weak, nonatomic) IBOutlet UIButton *actionOut;
@property (weak, nonatomic) IBOutlet UILabel *taskTime;
@property (weak, nonatomic) IBOutlet UILabel *taskDate;
@property (weak, nonatomic) IBOutlet UILabel *taskDueDate;
@property (weak, nonatomic) IBOutlet UILabel *taskDueTime;


@end
