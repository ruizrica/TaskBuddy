//
//  taskListCell.m
//  taskBuddy
//
//  Created by Ricardo Ruiz on 12/23/13.
//  Copyright (c) 2013 iOS Apps Development. All rights reserved.
//

#import "taskListCell.h"

@implementation taskListCell
@synthesize taskNameLabel, dueDateLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
