//
//  doneButton.m
//  taskbuddy
//
//  Created by Ricardo Ruiz on 1/16/14.
//  Copyright (c) 2014 iOS Apps Development. All rights reserved.
//

#import "doneButton.h"

@implementation doneButton

- (id)init
{
    CGSize sizeOfText = [[self titleForButton] sizeWithAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14.f]}];
    
    self = [super initWithFrame:CGRectMake(0, 0, sizeOfText.width + 18.104, sizeOfText.height + 10.298)];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.0];
        
        self.layer.cornerRadius = 3.0f;
        self.layer.borderWidth = 1.0f;
        self.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:1.0].CGColor;
        
        [self setTitle:[self titleForButton] forState:UIControlStateNormal];
        
        [self setTitleColor:[UIColor colorWithWhite:0.500 alpha:1.0] forState:UIControlStateNormal];
        
        self.titleLabel.font = [UIFont boldSystemFontOfSize:14.f];
        self.titleLabel.textColor = [UIColor darkGrayColor];
        
        [self addTarget:self action:@selector(buttonTarget) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


- (NSString*)titleForButton {
    return @"Done";
}

- (void)buttonTarget {
    [[RFToolbarButton textView] setKeyboardType:UIKeyboardTypeDefault];
    [[RFToolbarButton textView] resignFirstResponder];
}

@end
