//
//  poButton.m
//  taskbuddy
//
//  Created by Ricardo Ruiz on 1/16/14.
//  Copyright (c) 2014 iOS Apps Development. All rights reserved.
//

#import "poButton.h"

@implementation poButton

- (NSString*)titleForButton {
    return @"PO#";
}

- (void)buttonTarget {
    [[RFToolbarButton textView] setKeyboardType:UIKeyboardTypeNumberPad];
    [[RFToolbarButton textView] resignFirstResponder];
    [[RFToolbarButton textView] becomeFirstResponder];
    [[RFToolbarButton textView] insertText:@"PO#"];
    //UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Custom Keyboard" message:@"Custom Key Pressed" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
    
    //[alert show];
}

@end
