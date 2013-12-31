//
//  detailVC.m
//  taskBuddy
//
//  Created by Ricardo Ruiz on 12/28/13.
//  Copyright (c) 2013 iOS Apps Development. All rights reserved.
//

#import "detailVC.h"
#import "RFKeyboardToolbar/RFKeyboardToolbar.h"

@interface detailVC ()

@end

@implementation detailVC
@synthesize tf_dueDate, tf_taskName, tv_description, taskData, objectID;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //[self loadObjects];
    
    self.title = @"Edit Task";
    
    
    
	tf_taskName.text = taskData.taskName;
    tv_description.text = taskData.taskDescription;
    objectID = taskData.taskObjectId;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/YY '@' h:mma"];
    
    NSString *dateString = [dateFormatter stringFromDate:taskData.taskDueDate];
    
    NSString *dueDateString = [NSString stringWithFormat:@"Due: %@", dateString];
    
    tf_dueDate.text =  dueDateString;
    
    RFToolbarButton *exampleButton = [RFToolbarButton new];
    
    [RFKeyboardToolbar addToTextView:tv_description withButtons:@[exampleButton]];
    
    [self.view addSubview:tv_description];
    
    NSLog(objectID);
}


- (IBAction)selectDueDate:(id)sender {
    [tf_taskName resignFirstResponder];
    [tv_description resignFirstResponder];
    
    RMDateSelectionViewController *dateSelectionVC = [RMDateSelectionViewController dateSelectionController];
    dateSelectionVC.delegate = self;
    
    [dateSelectionVC show];
}

#pragma mark - RMDateSelectionViewController Delegates
- (void)dateSelectionViewController:(RMDateSelectionViewController *)vc didSelectDate:(NSDate *)aDate {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/YY '@' h:mma"];
    NSString *stringFromDate = [formatter stringFromDate:aDate];
    NSString *dateString = [NSString stringWithFormat:@"Due: %@", stringFromDate];
    
    local_taskDueDate = aDate;
    tf_dueDate.text = dateString;
}


- (void)dateSelectionViewControllerDidCancel:(RMDateSelectionViewController *)vc {
    NSLog(@"User Cancelled Input");
}

- (IBAction)updateTask:(id)sender {
    //taskModel *taskData = [[taskModel alloc]init];
    
    NSLog(objectID);
    
    taskData.taskName = tf_taskName.text;
    taskData.taskDueDate = local_taskDueDate;
    taskData.taskDescription = tv_description.text;
    
    PFQuery *query = [PFQuery queryWithClassName:@"task"];
    
    // Retrieve the object by id
    [query getObjectInBackgroundWithId:objectID block:^(PFObject *_taskData, NSError *error) {
        
        // Now let's update it with some new data. In this case, only cheatMode and score
        // will get sent to the cloud. playerName hasn't changed.
        _taskData[@"taskStatus"] = @NO;
        _taskData[@"taskDescription"] = taskData.taskDescription;
        [_taskData saveInBackground];
        
    }];
    
    /*PFObject *taskObject = [PFObject objectWithClassName:@"task"];
    [taskObject setObject:taskData.taskName forKey:@"taskName"];
    [taskObject setObject:taskData.taskDueDate forKey:@"taskDueDate"];
    [taskObject setObject:taskData.taskDescription forKey:@"taskDescription"];
    [taskObject saveInBackground];*/
    
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
