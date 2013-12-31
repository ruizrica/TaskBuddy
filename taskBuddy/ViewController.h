//
//  ViewController.h
//  taskBuddy
//
//  Created by Ricardo Ruiz on 12/10/13.
//  Copyright (c) 2013 iOS Apps Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController</*UITableViewDelegate, UITableViewDataSource, */UITextViewDelegate>

- (IBAction)createTaskButton:(id)sender;
- (IBAction)taskListButton:(id)sender;
//@property (strong, nonatomic) IBOutlet UITableView *menuTableView;
- (IBAction)clearBadges:(id)sender;


@end
