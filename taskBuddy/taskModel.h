//
//  taskModel.h
//  taskBuddy
//
//  Created by Ricardo Ruiz on 12/10/13.
//  Copyright (c) 2013 iOS Apps Development. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface taskModel : NSObject
@property (nonatomic,strong) NSString *taskName;
@property (nonatomic,strong) NSString *taskDescription;
@property (nonatomic,strong) NSString *taskRequestedBy;
@property (nonatomic,strong) UIImage *taskImage;
@property (nonatomic,strong) NSDate * taskDueDate;
@property (nonatomic,strong) NSDate * taskCreatedDate;
@property (nonatomic) BOOL taskStatus;
@property (nonatomic) BOOL taskPriority;
@property (nonatomic) float userLocLat;
@property (nonatomic) float userLocLon;

- (id)initWithTaskName:(NSString *)theTaskName
       taskDescription:(NSString *)theTaskDescription
       taskRequestedBy:(NSString *)theTaskRequestedBy
             taskImage:(UIImage *)theTaskImage
           taskDueDate:(NSDate *)theTaskDueDate
           taskCreatedDate:(NSDate *)theTaskCreatedDate
            taskStatus:(BOOL)theTaskStatus
          taskPriority:(BOOL)theTaskPriority
            userLocLat:(float)theUserLocLat
           userLocaLon:(float)theUserLocLon;

@end
