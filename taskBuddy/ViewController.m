//
//  ViewController.m
//  taskBuddy
//
//  Created by Ricardo Ruiz on 12/10/13.
//  Copyright (c) 2013 iOS Apps Development. All rights reserved.
//

#import "ViewController.h"
#import "createVC.h"
#import "taskListVC.h"
#import "CTFeedbackViewController.h"


@implementation ViewController
//@synthesize menuTableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib
    
    self.title = @"TaskBuddy v1.2";
    
}

- (IBAction)clearBadges:(id)sender {
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"TaskBuddy" message:@"Notification Badges Cleared" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
    
    [alert show];
    
    
}
- (IBAction)speak:(id)sender {
    AVSpeechSynthesizer *synthesizer = [[AVSpeechSynthesizer alloc] init];
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:@"Trala la la la, do dat do"];
    utterance.rate = 0.2; // Tell it to me slowly
    [synthesizer speakUtterance:utterance];
    
}

- (IBAction)createTaskButton:(id)sender {
    
    createVC *createVC_object = [self.storyboard instantiateViewControllerWithIdentifier:@"createTask"];
    [self.navigationController pushViewController:createVC_object animated:YES];
}

- (IBAction)taskListButton:(id)sender {
    
    taskListVC *listVC_object = [self.storyboard instantiateViewControllerWithIdentifier:@"taskList"];
    [self.navigationController pushViewController:listVC_object animated:YES];
}

- (IBAction)feedbackButton:(id)sender {
    
    CTFeedbackViewController *feedbackViewController = [CTFeedbackViewController controllerWithTopics:CTFeedbackViewController.defaultTopics localizedTopics:CTFeedbackViewController.defaultLocalizedTopics];
    feedbackViewController.toRecipients = @[@"admin@iosappsdev.org"];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:feedbackViewController];
    
    [self presentViewController:navigationController animated:YES completion:nil];
}
@end
