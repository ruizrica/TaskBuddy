//
//  importantButton.m
//  taskbuddy
//
//  Created by Ricardo Ruiz on 12/30/13.
//  Copyright (c) 2013 iOS Apps Development. All rights reserved.
//

#import "importantButton.h"

@implementation importantButton

- (NSString*)titleForButton {
    return @"Important";
}

- (void)buttonTarget {
    [[RFToolbarButton textView] insertText:@"##IMPORTANT##"];
    //UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Custom Keyboard" message:@"Custom Key Pressed" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
    
    //[alert show];
}

@end
