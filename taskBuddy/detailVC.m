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
@synthesize label_dueDate, label_taskName, textView_description, taskData;

- (void)viewDidLoad
{
    [super viewDidLoad];
	label_taskName.text = taskData.taskName;
    textView_description.text = taskData.taskDescription;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/YY '@' h:mma"];
    
    NSString *dateString = [dateFormatter stringFromDate:taskData.taskDueDate];
    
    NSString *dueDateString = [NSString stringWithFormat:@"Due: %@", dateString];
    
    label_dueDate.text =  dueDateString;
    
    RFToolbarButton *exampleButton = [RFToolbarButton new];
    
    [RFKeyboardToolbar addToTextView:textView_description withButtons:@[exampleButton]];
    
    [self.view addSubview:textView_description];
}


@end
