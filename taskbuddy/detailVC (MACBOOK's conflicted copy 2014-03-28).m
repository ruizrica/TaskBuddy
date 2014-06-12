//
//  detailVC.m
//  taskBuddy
//
//  Created by Ricardo Ruiz on 12/28/13.
//  Copyright (c) 2013 iOS Apps Development. All rights reserved.
//

#import "detailVC.h"
#import "RFKeyboardToolbar/RFKeyboardToolbar.h"
#import "constants.h"
#import "keyboardContants.h"

#define USERNAME @"USERNAME"

@import AVFoundation;

@implementation detailVC
@synthesize tf_dueDate, tf_taskName, tv_description, taskData, objectID, tf_createdDate, tf_modifiedDate, tf_modifiedBy;

//Alternate Queue For Uploading
dispatch_queue_t parseQueue;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //[self loadObjects];
    
    self.title = @"Edit Task";
    
    objectID = taskData.taskObjectId;
    
    NSString *userMessage = [NSString stringWithFormat:@"Modified By: %@", USERNAME];
    
    tf_modifiedBy.text = userMessage;
    
    //Due Date
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/YY '@' h:mma"];
    NSString *_dueDate = [dateFormatter stringFromDate:taskData.taskDueDate];
    NSString *dueDate = [NSString stringWithFormat:@"Due: %@", _dueDate];
    
    //Created Date
    NSString *_createdDate = [dateFormatter stringFromDate:taskData.taskCreatedDate];
    NSString *createdDate = [NSString stringWithFormat:@"Created: %@", _createdDate];
    
    //Modified Date
    NSString *_modifiedDate = [dateFormatter stringFromDate:taskData.taskModifiedDate];
    NSString *modifiedDate = [NSString stringWithFormat:@"Last Update: %@", _modifiedDate];
    
    tf_taskName.text = taskData.taskName;
    tv_description.text = taskData.taskDescription;
    
    tf_dueDate.text = dueDate;
    local_dueDate = dueDate;
    
    tf_createdDate.text = createdDate;
    local_createdDate = createdDate;
    
    tf_modifiedDate.text = modifiedDate;
    local_modifiedDate = modifiedDate;
    
    doneButton *_doneButton = [doneButton new];
    
    [RFKeyboardToolbar addToTextView:tv_description withButtons:@[_doneButton]];
    
    [self.view addSubview:tv_description];
    
    UIBarButtonItem *deleteButton = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteObject)];
    self.navigationItem.rightBarButtonItem = deleteButton;
}

-(void)deleteObject {
    
    //Remove object from Tableview
    PFObject *object = [PFObject objectWithoutDataWithClassName:@"task" objectId:objectID];
    
    [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
        //Reload Table Data
        NSLog(@"Deleted Object ID: %@", objectID);
        [SVProgressHUD showSuccessWithStatus:@"Task Deleted"];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}


- (IBAction)selectDueDate:(id)sender {
    [tf_taskName resignFirstResponder];
    [tv_description resignFirstResponder];
    
    RMDateSelectionViewController *dateSelectionVC = [RMDateSelectionViewController dateSelectionController];
    dateSelectionVC.delegate = self;
    
    [dateSelectionVC show];
}

- (IBAction)speakTaskInfo:(id)sender {
    AVSpeechSynthesizer *tom = [[AVSpeechSynthesizer alloc]init];
    
    //NSString *taskInfo = [NSString stringWithFormat:@"%@, %@, %@, %@", taskData.taskName, local_dueDate, taskData.taskDescription, local_modifiedDate];
    
    NSString *taskInfo = [NSString stringWithFormat:@"%@", tv_description.text];
    
    AVSpeechUtterance *speakTaskInfo = [AVSpeechUtterance speechUtteranceWithString:taskInfo];
    
    [speakTaskInfo setRate:0.2f];
    [speakTaskInfo setVolume:0.8f];
    
    [tom speakUtterance:speakTaskInfo];
}

#pragma mark - RMDateSelectionViewController Delegates
- (void)dateSelectionViewController:(RMDateSelectionViewController *)vc didSelectDate:(NSDate *)aDate {
    
    taskData.taskDueDate = aDate;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/YY '@' h:mma"];
    NSString *stringFromDate = [formatter stringFromDate:aDate];
    NSString *dateString = [NSString stringWithFormat:@"Due: %@", stringFromDate];
    
    tf_dueDate.text = dateString;
    local_dueDate = dateString;
}


- (void)dateSelectionViewControllerDidCancel:(RMDateSelectionViewController *)vc {
    NSLog(@"User Cancelled Input");
}

- (IBAction)updateTask:(id)sender {
    parseQueue = dispatch_queue_create("parseQueue", NULL);

    taskData.taskName = tf_taskName.text;
    local_taskDueDate = taskData.taskDueDate;
    taskData.taskDescription = tv_description.text;
    
    PFQuery *query = [PFQuery queryWithClassName:@"task"];
    
    // Retrieve the object by id
    [query getObjectInBackgroundWithId:objectID block:^(PFObject *_taskData, NSError *error) {
        
        //_taskData[@"taskStatus"] = @NO;
        _taskData[@"taskName"] = taskData.taskName;
        _taskData[@"taskDescription"] = taskData.taskDescription;
        _taskData[@"taskDueDate"] = taskData.taskDueDate;
        
        NSLog(@"%@ -UPDATED", local_dueDate);
        
        //GCD Code
        dispatch_async(parseQueue, ^{
            
            [_taskData saveEventually:^(BOOL succeeded, NSError *error)
            {
                NSLog(@"Object:%@ was updated.",objectID);
            }];
        });
        }];


    // Schedule the notification
    /*UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = taskData.taskDueDate;
    localNotification.alertBody = taskData.taskName;
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.alertAction = @"Show me the item";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];*/
     
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"TaskBuddy"
                                                   message:@"Your Task Was Updated"
                                                  delegate:self
                                         cancelButtonTitle:@"Ok"
                                         otherButtonTitles: nil];
    
    [alert show];
}

// Event Handler for AlertView
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self dismissKeyboardAction];
    return YES;
}

/*- (void)dismissKeyboard:(id)sender {
    [self dismissKeyboardAction];
}

- (void)shareContent:(id)sender {
    
    NSString *titleString = tf_taskName.text;
    NSString *descriptionString = tv_description.text;
    
    NSArray *objectsToShare = @[titleString,descriptionString];
    
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    [self presentViewController:controller animated:YES completion:nil];
}
*/
- (void)dismissKeyboardAction {
    [tf_taskName resignFirstResponder];
    [tv_description resignFirstResponder];
}

@end
