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

@interface createVC : UIViewController<UIAlertViewDelegate, UITextViewDelegate, RMDateSelectionViewControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
    
    NSDate *local_taskDueDate;
    UIImage *local_taskImage;
    
}

@property (strong, nonatomic) IBOutlet UITextField *tf_taskName;
@property (strong, nonatomic) IBOutlet UITextField *tf_taskDueDate;
@property (strong, nonatomic) IBOutlet GCPlaceholderTextView *tv_taskDescription;

@property (strong, nonatomic) IBOutlet UIButton *_category;
@property (strong, nonatomic) IBOutlet UIButton *_priority;
@property (strong, nonatomic) IBOutlet UIButton *_budget;
@property (strong, nonatomic) IBOutlet UIImageView *userImageView;

@property (strong, nonatomic) taskModel *dataModel;

- (IBAction)button_category:(id)sender;
- (IBAction)button_priority:(id)sender;
- (IBAction)button_budget:(id)sender;

- (IBAction)selectDueDate:(id)sender;
- (IBAction)saveTask:(id)sender;
- (IBAction)dismissKeyboard:(id)sender;

@end
