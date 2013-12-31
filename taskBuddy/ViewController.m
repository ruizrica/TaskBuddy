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
#import "menuCell.h"

@interface ViewController () {
    NSArray *menuItems;
    NSArray *menuImages;
}

@end

@implementation ViewController
@synthesize menuTableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib
    
    menuItems = @[@"Create Task",@"Task List"];
    
    menuImages = @[@"menu_icon1.png", @"menu_icon2.png"];
    
    self.title = @"TaskBuddy v1.2";
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    menuCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.menuCell_namelabel.text = [menuItems objectAtIndex:indexPath.row];
    
    cell.menuCell_image.image = [UIImage imageNamed:[menuImages objectAtIndex:indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
        
        //Clear Selection
        [menuTableView deselectRowAtIndexPath:indexPath animated:YES];
        
        switch (indexPath.row) {
                // Create Task
            case 0:{
                createVC *createVC_object = [self.storyboard instantiateViewControllerWithIdentifier:@"createTask"];
                [self.navigationController pushViewController:createVC_object animated:YES];
                //NSLog(@"Inside createVC_object");
            }
                break;
                // List Tasks
            case 1:{
                taskListVC *listVC_object = [self.storyboard instantiateViewControllerWithIdentifier:@"taskList"];
                [self.navigationController pushViewController:listVC_object animated:YES];
            }
                break;
                
            default:
                break;
        }
        
    }


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
 */

- (IBAction)clearBadges:(id)sender {
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"TaskBuddy" message:@"Notification Badges Cleared" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
    
    [alert show];
    
    
}
@end
