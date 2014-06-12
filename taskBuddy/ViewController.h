//
//  ViewController.h
//  taskBuddy
//
//  Created by Ricardo Ruiz on 12/10/13.
//  Copyright (c) 2013 iOS Apps Development. All rights reserved.
//

#import <UIKit/UIKit.h>
@import AVFoundation;

@interface ViewController : UIViewController<UITextViewDelegate>
- (IBAction)speak:(id)sender;

- (IBAction)createTaskButton:(id)sender;
- (IBAction)taskListButton:(id)sender;
- (IBAction)clearBadges:(id)sender;


@end
