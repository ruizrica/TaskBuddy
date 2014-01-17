//
//  soButton.m
//  taskbuddy
//
//  Created by Ricardo Ruiz on 1/16/14.
//  Copyright (c) 2014 iOS Apps Development. All rights reserved.
//

#import "soButton.h"

@implementation soButton

- (NSString*)titleForButton {
    return @"ORDER#";
}

- (void)buttonTarget {
    [[RFToolbarButton textView] setKeyboardType:UIKeyboardTypeNumberPad];
    [[RFToolbarButton textView] resignFirstResponder];
    [[RFToolbarButton textView] becomeFirstResponder];
    [[RFToolbarButton textView] insertText:@"ORDER# "];
    //UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Custom Keyboard" message:@"Custom Key Pressed" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
    
    //[alert show];
}

@end
