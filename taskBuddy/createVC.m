//
//  createVC.m
//  taskBuddy
//
//  Created by Ricardo Ruiz on 12/10/13.
//  Copyright (c) 2013 iOS Apps Development. All rights reserved.
//

#import "createVC.h"


@implementation createVC
@synthesize tf_taskName, tf_taskDueDate, tv_taskDescription, uis_prioritySwitch/*, taskData*/;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Create Task";

    tv_taskDescription.placeholder = @"Description";
    //[tf_taskName becomeFirstResponder];
    
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

- (IBAction)selectDueDate:(id)sender {
    [tf_taskName resignFirstResponder];
    [tv_taskDescription resignFirstResponder];
    
    RMDateSelectionViewController *dateSelectionVC = [RMDateSelectionViewController dateSelectionController];
    dateSelectionVC.delegate = self;
    
    [dateSelectionVC show];
}

- (IBAction)saveTask:(id)sender {
    
    isPriority = uis_prioritySwitch.selected;
    
    taskModel *taskData = [[taskModel alloc]init];
    
    taskData.taskName = tf_taskName.text;
    taskData.taskDueDate = local_taskDueDate;
    taskData.taskDescription = tv_taskDescription.text;
    //taskData.taskPriority = isPriority;
    //NSString *boolString = [NSString stringWithFormat: @" %s", isPriority ? "true" : "false"];
    
    //Used for model debugging
    //
    //NSString *logString = [NSString stringWithFormat:@"%@, %@,", taskData.taskName, taskData.taskDescription];
    //NSLog(logString);
    
    PFObject *taskObject = [PFObject objectWithClassName:@"task"];
    [taskObject setObject:taskData.taskName forKey:@"taskName"];
    [taskObject setObject:taskData.taskDueDate forKey:@"taskDueDate"];
    [taskObject setObject:taskData.taskDescription forKey:@"taskDescription"];
    //[taskObject setObject:NO forKey:@"priority"];
 
    //taskObject[@"priority"] = uis_prioritySwitch.selected;
    [taskObject saveInBackground];
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"TaskBuddy" message:@"Your Task Was Saved" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    
    [alert show];
}
- (IBAction)dismissKeyboard:(id)sender {
    [tf_taskName resignFirstResponder];
    [tv_taskDescription resignFirstResponder];
}
@end
