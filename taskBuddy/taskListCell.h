//
//  taskListCell.h
//  taskBuddy
//
//  Created by Ricardo Ruiz on 12/23/13.
//  Copyright (c) 2013 iOS Apps Development. All rights reserved.
//

#import <Parse/Parse.h>

@interface taskListCell : PFTableViewCell
@property (strong, nonatomic) IBOutlet UILabel *taskNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *dueDateLabel;

@end
