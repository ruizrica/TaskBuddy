//
//  createVC.h
//  taskBuddy
//
//  Created by Ricardo Ruiz on 12/10/13.
//  Copyright (c) 2013 iOS Apps Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "RMDateSelectionViewController.h"
#import "GCPlaceholderTextView.h"
#import "taskModel.h"

@interface createVC : UIViewController<RMDateSelectionViewControllerDelegate> {
    NSDate *local_taskDueDate;
    Boolean isPriority;
    
}
- (IBAction)selectDueDate:(id)sender;
- (IBAction)saveTask:(id)sender;
- (IBAction)dismissKeyboard:(id)sender;
@property (strong, nonatomic) IBOutlet UISwitch *uis_prioritySwitch;
@property (strong, nonatomic) IBOutlet UITextField *tf_taskName;
@property (strong, nonatomic) IBOutlet UITextField *tf_taskDueDate;
@property (strong, nonatomic) IBOutlet GCPlaceholderTextView *tv_taskDescription;

//@property (strong,nonatomic) taskModel *taskData;

@end
