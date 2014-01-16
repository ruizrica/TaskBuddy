//
//  taskListVC.m
//  taskBuddy
//
//  Created by Ricardo Ruiz on 12/23/13.
//  Copyright (c) 2013 iOS Apps Development. All rights reserved.
//

#import "taskListVC.h"
#import "taskListCell.h"
#import "detailVC.h"


@interface taskListVC () {
    NSIndexPath *deleteIndexPath;
    NSString *local_createdDate;
}

@end

@implementation taskListVC

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.title = @"Task List";
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidAppear:(BOOL)animated {
    //Reload Table Data
    [self loadObjects];
}

#pragma mark - Table view data source

-(id)initWithCoder:(NSCoder *)aCoder {
    self = [super initWithCoder:aCoder];
    
    if (self) {
        
        //Set Class Name
        self.parseClassName = @"task";
        
        //Pull to Refresh
        self.pullToRefreshEnabled = YES;
        
        //Enable Paging
        self.paginationEnabled = YES;
    }
    return self;
}

-(PFQuery *)queryForTable {
    PFQuery * query = [PFQuery queryWithClassName:@"task"];
   [query orderByAscending:@"createdAt"];
    
    return query;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    
    static NSString *cellID = @"taskListCell";
    
    taskListCell *cell = (taskListCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[taskListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/YY '@' h:mma"];
    NSString *_dueDateString = [dateFormatter stringFromDate:[object objectForKey:@"taskDueDate"]];
    NSString *dueDateString = [NSString stringWithFormat:@"Due: %@", _dueDateString];
    
    cell.taskNameLabel.text = [object objectForKey:@"taskName"];
    cell.dueDateLabel.text = dueDateString;
    
    return cell;
    
}

/*
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    detailVC *DetailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"detailVC"];
    [self.navigationController pushViewController:DetailVC animated:YES];
    
    NSLog(@"Navigate to DetailVC");
}
*/
/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        deleteIndexPath = indexPath;
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Delete Task" message:@"Are you sure you want to delete this Task?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        
        [alert show];
        
    }
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        //Reload Table Data
        [self loadObjects];
    } else {
        
        //[self.tableView deleteRowsAtIndexPaths:@[deleteIndexPath.row] withRowAnimation:UITableViewRowAnimationLeft];
        
        //Remove object from Tableview
        PFObject *object = [self.objects objectAtIndex:deleteIndexPath.row];
        
        [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
            //Reload Table Data
            [self loadObjects];
        }];

    }

    
}

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


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"taskSegue"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        detailVC *dvc = segue.destinationViewController;
        
        PFObject *object = [self.objects objectAtIndex:indexPath.row];
        
        NSString *objectID = [object objectId];
        
        NSLog(@"Selected Object ID: %@", objectID);
        
        taskModel *_taskData = [[taskModel alloc]init];
        
        _taskData.taskName = [object objectForKey:@"taskName"];
        _taskData.taskDueDate = [object objectForKey:@"taskDueDate"];
        _taskData.taskDescription = [object objectForKey:@"taskDescription"];
        _taskData.taskCreatedDate = object.createdAt;
        _taskData.taskModifiedDate = object.updatedAt;
        _taskData.taskObjectId = objectID;
        
        dvc.taskData = _taskData;
        
    }
}



@end
