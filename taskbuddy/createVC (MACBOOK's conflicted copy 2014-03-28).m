//
//  createVC.m
//  taskBuddy
//
//  Created by Ricardo Ruiz on 12/10/13.
//  Copyright (c) 2013 iOS Apps Development. All rights reserved.
//

#import "createVC.h"
#import "RFKeyboardToolbar/RFKeyboardToolbar.h"
#import "REDActionSheet.h"
#import "keyboardContants.h"
#import "SVProgressHUD.h"

@interface createVC ()

@end

@implementation createVC
@synthesize tf_taskName, tf_taskDueDate, tv_taskDescription, _budget, _category,_priority, userImageView, dataModel;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"Create Task";

    tv_taskDescription.placeholder = @"Description";
    [tf_taskName becomeFirstResponder];
    
    doneButton *_doneButton = [doneButton new];
    //asparagusButton *_asparagusButton = [asparagusButton new];
    //rtsButton *_rtsButton = [rtsButton new];
    //poButton *_poButton = [poButton new];
    //soButton *_soButton = [soButton new];
    
    [RFKeyboardToolbar addToTextView:tv_taskDescription withButtons:@[_doneButton/*, _poButton, _soButton, _rtsButton, _asparagusButton*/]];
    
    [self.view addSubview:tv_taskDescription];
    
    UIBarButtonItem *cameraButton = [[UIBarButtonItem alloc]
                                     initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(showCamera)];
    self.navigationItem.rightBarButtonItem = cameraButton;
    
}

-(void)showCamera {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];

    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *userImage = info[UIImagePickerControllerOriginalImage];
    local_taskImage = userImage;
    userImageView.image = userImage;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    NSLog(@"User Cancelled Selection");
}


#pragma mark - RMDateSelectionViewController Delegates
- (void)dateSelectionViewController:(RMDateSelectionViewController *)vc didSelectDate:(NSDate *)aDate {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/YY '@' h:mma"];
    NSString *stringFromDate = [formatter stringFromDate:aDate];
    NSString *dateString = [NSString stringWithFormat:@"Due: %@", stringFromDate];
    
    local_taskDueDate = aDate;
    tf_taskDueDate.text = dateString;
}


- (void)dateSelectionViewControllerDidCancel:(RMDateSelectionViewController *)vc {
    NSLog(@"User Cancelled Input");
}

- (IBAction)button_category:(id)sender {
    [self dismissKeyboardAction];
    
    REDActionSheet *actionSheet = [[REDActionSheet alloc] initWithCancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitlesList:@"Work", @"Personal", @"School", nil];
    
	actionSheet.actionSheetTappedButtonAtIndexBlock = ^(REDActionSheet *actionSheet, NSUInteger buttonIndex) {
		
        switch (buttonIndex) {

            case 0: {
                NSLog(@"Case 0");
                _category.imageView.image = [UIImage imageNamed:@""];
                _category.titleLabel.text = @"Work";
            }
                break;
                
            case 1: {
                NSLog(@"Case 1");
                _category.imageView.image = [UIImage imageNamed:@""];
                _category.titleLabel.text = @"Personal";
                
            }
                break;
                
            case 2: {
                NSLog(@"Case 2");
                _category.imageView.image = [UIImage imageNamed:@""];
                _category.titleLabel.text = @"School";
            }
                break;
                
            default:
                break;
        }
        
        
        
	};
	[actionSheet showInView:self.view];
}

- (IBAction)button_priority:(id)sender {
    [self dismissKeyboardAction];
    
    REDActionSheet *actionSheet = [[REDActionSheet alloc] initWithCancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitlesList:@"High Priority", @"Normal Priority", @"Low Priority", nil];
	actionSheet.actionSheetTappedButtonAtIndexBlock = ^(REDActionSheet *actionSheet, NSUInteger buttonIndex) {
		
        switch (buttonIndex) {
                
            case 0: {
                NSLog(@"Case 0");
            }
                break;
                
            case 1: {
                NSLog(@"Case 1");
            }
                break;
                
            case 2: {
                NSLog(@"Case 2");
            }
                break;
                
            default:
                break;
        }
        
        
        
	};
	[actionSheet showInView:self.view];
}

- (IBAction)button_budget:(id)sender {
    //[self dismissKeyboardAction];
    
    UIAlertView *alert =  [[UIAlertView alloc]initWithTitle:@"Developer Preview" message:@"Feature Not Available" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    
    alert.tag = 0;
    
    [alert show];
}


// Button Action for Due Date
- (IBAction)selectDueDate:(id)sender {
    [tf_taskName resignFirstResponder];
    [tv_taskDescription resignFirstResponder];
    
    RMDateSelectionViewController *dateSelectionVC = [RMDateSelectionViewController dateSelectionController];
    dateSelectionVC.delegate = self;
    
    [dateSelectionVC show];
}

// Button Action for Saving Task
// - Needs GCD code.
- (IBAction)saveTask:(id)sender {
    
    dispatch_queue_t parseUpload;
    parseUpload = dispatch_queue_create("parseUpload", NULL);
    
    if (tf_taskName.text.length == 0 || local_taskDueDate == Nil) {
        
        UIAlertView *alertNoData = [[UIAlertView alloc]initWithTitle:@"Missing Information" message:@"Please enter a Task Name and Due Date." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
        
        alertNoData.tag = 0;
        
        [alertNoData show];
        
    } else {
    
    dataModel.taskName = tf_taskName.text;
    dataModel.taskDueDate = local_taskDueDate;
    dataModel.taskDescription = tv_taskDescription.text;
    dataModel.taskImage = local_taskImage;
    
    
    PFObject *taskObject = [PFObject objectWithClassName:@"task"];
        
    [taskObject setObject:dataModel.taskName forKey:@"taskName"];
    [taskObject setObject:dataModel.taskDueDate forKey:@"taskDueDate"];
    [taskObject setObject:dataModel.taskDescription forKey:@"taskDescription"];
    [taskObject setObject:dataModel.taskImage forKey:@"taskImage"];
    [SVProgressHUD show];
    
        dispatch_async(parseUpload, ^{
            [taskObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                [SVProgressHUD dismiss];
                [SVProgressHUD showSuccessWithStatus:@"Task Saved"];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
                });
            }];
        });
    
    // Schedule the notification
    /*UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = taskData.taskDueDate;
    localNotification.alertBody = taskData.taskName;
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.alertAction = @"Show me the item";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];*/
    
    //Deprecated
    //UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"TaskBuddy"message:@"Your Task Was Saved" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    //alert.tag = 1;
    //[alert show];
    }
}


// Event Handler for AlertView
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    //Handle Multiple Alertviews
    if (alertView.tag == 1) {
        
        if (buttonIndex == 0) {
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else {
        NSLog(@"Alertnate Alertview Handler Called");
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self dismissKeyboardAction];
    return YES;
}

- (IBAction)dismissKeyboard:(id)sender {
    [self dismissKeyboardAction];
}

- (void)dismissKeyboardAction {
    [tf_taskName resignFirstResponder];
    [tv_taskDescription resignFirstResponder];
}

@end
