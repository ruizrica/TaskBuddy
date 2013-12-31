//
//  taskModel.m
//  taskBuddy
//
//  Created by Ricardo Ruiz on 12/10/13.
//  Copyright (c) 2013 iOS Apps Development. All rights reserved.
//

#import "taskModel.h"

@implementation taskModel
@synthesize taskName, taskDescription, taskImage, taskStatus, taskPriority, taskRequestedBy, userLocLat, userLocLon, taskDueDate, taskCreatedDate, taskObjectId;

- (id)initWithTaskName:(NSString *)theTaskName
       taskDescription:(NSString *)theTaskDescription
       taskRequestedBy:(NSString *)theTaskRequestedBy
             taskImage:(UIImage *)theTaskImage
           taskDueDate:(NSDate *)theTaskDueDate
       taskCreatedDate:(NSDate *)theTaskCreatedDate
            taskStatus:(BOOL)theTaskStatus
          taskPriority:(BOOL)theTaskPriority
            userLocLat:(float)theUserLocLat
           userLocaLon:(float)theUserLocLon

             {
    
    self = [super init];
    
    if(self) {
        
        self.taskName = theTaskName;
        self.taskDescription = theTaskDescription;
        self.taskStatus = YES;
        self.taskPriority = NO;
        self.taskRequestedBy = theTaskRequestedBy;
        self.taskImage = theTaskImage;
        self.taskDueDate = theTaskDueDate;
        self.taskCreatedDate = theTaskCreatedDate;
        self.userLocLat = theUserLocLat;
        self.userLocLon = theUserLocLon;

    }
    return self;

    
}


@end
