//
//  detailVC.h
//  taskBuddy
//
//  Created by Ricardo Ruiz on 12/28/13.
//  Copyright (c) 2013 iOS Apps Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "taskModel.h"

@interface detailVC : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *label_taskName;
@property (strong, nonatomic) IBOutlet UILabel *label_dueDate;
@property (strong, nonatomic) IBOutlet UITextView *textView_description;

@property (strong, nonatomic) taskModel *taskData;

@end
