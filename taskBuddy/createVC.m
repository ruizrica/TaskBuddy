//
//  createVC.m
//  taskBuddy
//
//  Created by Ricardo Ruiz on 12/10/13.
//  Copyright (c) 2013 iOS Apps Development. All rights reserved.
//

#import "createVC.h"
#import "RFKeyboardToolbar/RFKeyboardToolbar.h"


@implementation createVC
@synthesize tf_taskName, tf_taskDueDate, tv_taskDescription;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"Create Task";

    tv_taskDescription.placeholder = @"Description";
    [tf_taskName becomeFirstResponder];
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    /*RFToolbarButton *exampleButton = [RFToolbarButton new];
    // This is a RFToolbarButton subclass - you set the button title and the button's target in this subclass
    // You then import the subclass, and then alloc and init it with new
    
    tv_taskDescription = [[UITextView alloc] initWithFrame:self.view.bounds];
    // The underscore is to access the UITextView variable set in the @interface (you can see this in the demo)
    
    [RFKeyboardToolbar addToTextView:tv_taskDescription withButtons:@[exampleButton]];
    // Here's where the new magic happens (previously you could use UITextInput, and not have to worry about adding it for a UITextView/UIToolbar)**
    // The array is the arry of buttons you created and have "newed" above.  They will appear in the order you
    // add them from left to right.  You can access the textfield/view in the button subclasses to insert text
    // or do whatever you want via [RFToolbarButton textInput].  But you can see this in the example as well.
    
    // ** while working on RFMarkdownTextView, I realized that UITextInput is much less documented, and this isn't that much different, so I went with this.
    
    [self.view addSubview:tv_taskDescription];*/
    
    
    NSLog(@"user started editing");
    

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
    taskModel *taskData = [[taskModel alloc]init];
    
    taskData.taskName = tf_taskName.text;
    taskData.taskDueDate = local_taskDueDate;
    taskData.taskDescription = tv_taskDescription.text;
    
    PFObject *taskObject = [PFObject objectWithClassName:@"task"];
    [taskObject setObject:taskData.taskName forKey:@"taskName"];
    [taskObject setObject:taskData.taskDueDate forKey:@"taskDueDate"];
    [taskObject setObject:taskData.taskDescription forKey:@"taskDescription"];
    [taskObject saveInBackground];
    
    // Schedule the notification
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = taskData.taskDueDate;
    localNotification.alertBody = taskData.taskName;
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.alertAction = @"Show me the item";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"TaskBuddy"
                                                   message:@"Your Task Was Saved"
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

- (IBAction)dismissKeyboard:(id)sender {
    [self dismissKeyboardAction];
}

- (void)dismissKeyboardAction {
    [tf_taskName resignFirstResponder];
    [tv_taskDescription resignFirstResponder];
}


@end
