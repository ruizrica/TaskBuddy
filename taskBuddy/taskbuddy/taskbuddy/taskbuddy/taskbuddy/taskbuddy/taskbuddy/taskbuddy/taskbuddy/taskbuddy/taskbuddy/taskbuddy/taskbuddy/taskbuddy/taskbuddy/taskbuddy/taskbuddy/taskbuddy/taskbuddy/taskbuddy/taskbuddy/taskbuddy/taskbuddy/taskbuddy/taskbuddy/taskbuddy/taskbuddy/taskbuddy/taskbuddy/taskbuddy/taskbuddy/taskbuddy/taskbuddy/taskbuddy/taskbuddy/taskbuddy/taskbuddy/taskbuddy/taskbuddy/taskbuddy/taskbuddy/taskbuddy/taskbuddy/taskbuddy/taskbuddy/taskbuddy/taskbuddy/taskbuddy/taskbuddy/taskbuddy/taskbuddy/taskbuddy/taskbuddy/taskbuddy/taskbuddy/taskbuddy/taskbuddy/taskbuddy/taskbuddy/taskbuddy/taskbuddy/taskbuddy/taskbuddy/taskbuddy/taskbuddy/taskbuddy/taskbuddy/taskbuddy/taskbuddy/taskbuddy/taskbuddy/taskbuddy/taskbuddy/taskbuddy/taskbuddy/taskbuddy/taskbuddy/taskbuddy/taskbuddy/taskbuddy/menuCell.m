//
//  menuCell.m
//  taskBuddy
//
//  Created by Ricardo Ruiz on 12/22/13.
//  Copyright (c) 2013 iOS Apps Development. All rights reserved.
//

#import "menuCell.h"

@implementation menuCell
@synthesize menuCell_image, menuCell_namelabel;

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
