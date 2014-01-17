//
//  asparagusButton.m
//  taskbuddy
//
//  Created by Ricardo Ruiz on 1/16/14.
//  Copyright (c) 2014 iOS Apps Development. All rights reserved.
//

#import "asparagusButton.h"

@implementation asparagusButton

- (NSString*)titleForButton {
    return @"Asparagus";
}

- (void)buttonTarget {
    [[RFToolbarButton textView] insertText:@"Asparagus"];
    //UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Custom Keyboard" message:@"Custom Key Pressed" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
    
    //[alert show];
}


@end
