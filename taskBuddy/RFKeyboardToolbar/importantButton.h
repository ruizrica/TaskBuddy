//
//  importantButton.h
//  taskbuddy
//
//  Created by Ricardo Ruiz on 12/30/13.
//  Copyright (c) 2013 iOS Apps Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RFKeyboardToolbar.h"


@interface importantButton : UIButton

-(NSString*)titleForButton;
-(void)buttonTarget;

+ (void)setTextViewForButton:(UITextView*)textViewPassed;
+ (UITextView*)textView;

+ (void)setTextFieldForButton:(UITextField*)textFieldPassed;
+ (UITextField*)textField;

@end
