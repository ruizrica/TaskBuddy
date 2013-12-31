//
//  detailVC.h
//  taskBuddy
//
//  Created by Ricardo Ruiz on 12/28/13.
//  Copyright (c) 2013 iOS Apps Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "RMDateSelectionViewController.h"
#import "taskModel.h"

@interface detailVC : UIViewController<RMDateSelectionViewControllerDelegate> {
    NSDate *local_taskDueDate;
}
@property (strong, nonatomic) IBOutlet UITextField *tf_taskName;
@property (strong, nonatomic) IBOutlet UITextField *tf_dueDate;
@property (strong, nonatomic) IBOutlet UITextField *tf_createdDate;
@property (strong, nonatomic) IBOutlet UITextField *tf_modifiedDate;
@property (strong, nonatomic) IBOutlet UITextView *tv_description;
@property (strong, nonatomic) NSString *objectID;

@property (strong, nonatomic) taskModel *taskData;

- (IBAction)selectDueDate:(id)sender;

@end
