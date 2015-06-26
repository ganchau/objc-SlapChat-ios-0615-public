//
//  FISTableViewController.m
//  slapChat
//
//  Created by Joe Burgess on 6/27/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import "FISTableViewController.h"
#import "FISDataStore.h"
#import "Message.h"

@interface FISTableViewController ()

@property (nonatomic, strong) FISDataStore *dataManager;

@end

@implementation FISTableViewController

//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:style];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.dataManager = [FISDataStore sharedDataStore];
    
    Message *message1 = [NSEntityDescription insertNewObjectForEntityForName:@"Message"
                                                      inManagedObjectContext:self.dataManager.managedObjectContext];
    Message *message2 = [NSEntityDescription insertNewObjectForEntityForName:@"Message"
                                                      inManagedObjectContext:self.dataManager.managedObjectContext];
    Message *message3 = [NSEntityDescription insertNewObjectForEntityForName:@"Message"
                                                      inManagedObjectContext:self.dataManager.managedObjectContext];
    message1.content = @"Hello There";
    message2.createdAt = [NSDate date];
    
    message2.content = @"This is fun";
    message2.createdAt = [NSDate date];
    
    message3.content = @"I'm at the Flatiron School";
    message3.createdAt = [NSDate date];
    
    // Save the context
    [self.dataManager saveContext];
    
    
    // Fetch request called
    NSFetchRequest *messageFetch = [[NSFetchRequest alloc] initWithEntityName:@"Message"];
    self.messages = [self.dataManager.managedObjectContext executeFetchRequest:messageFetch
                                                         error:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return self.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"messageCellRID" forIndexPath:indexPath];
    
    // Configure the cell...
    Message *message = self.messages[indexPath.row];
    cell.textLabel.text = message.content;
    
    return cell;
}

- (IBAction)sortBarButtonTapped:(id)sender
{
    NSSortDescriptor *sortByDate = [NSSortDescriptor sortDescriptorWithKey:@"createdAt" ascending:NO];
    NSSortDescriptor *sortByContent = [NSSortDescriptor sortDescriptorWithKey:@"content" ascending:YES];
    
    // sort messages by content, then by date
    self.messages = [self.messages sortedArrayUsingDescriptors:@[sortByContent, sortByDate]];
    
    // refresh the table
    [self.tableView reloadData];
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
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
