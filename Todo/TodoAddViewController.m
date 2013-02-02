//
//  AddViewController.m
//  Todo
//
//  Created by Christophe on 02/02/13.
//  Copyright (c) 2013 FuriouZz. All rights reserved.
//

#import "TodoAddViewController.h"
#import "AddTaskView.h"

@interface TodoAddViewController ()

@end

@implementation TodoAddViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"addTask-TitleLabel", nil);
    NSString *addLabel = NSLocalizedString(@"AddButtonLabel", nil);
    NSString *cancelLabel = NSLocalizedString(@"CancelButtonLabel", nil);
    
    AddTaskView *addTaskView = [[[AddTaskView alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    addTaskView.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:cancelLabel
                                                               style:UIBarButtonItemStylePlain
                                                              target:self
                                                              action:@selector(cancel)];
    UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithTitle:addLabel
                                                            style:UIBarButtonSystemItemAdd
                                                           target:self
                                                           action:@selector(add)];
    
    addTaskView.navItem.title = self.title;
    addTaskView.navItem.leftBarButtonItem = cancel;
    addTaskView.navItem.rightBarButtonItem = add;
    
    [addTaskView addSubview:self.tableView];
    
    self.view = addTaskView;
    
    [cancel release];
    [add release];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (void)add
{
    [self.delegate todoAddViewControllerDidFinish:self];
}

- (void)cancel
{
    [self.delegate todoAddViewControllerDidFinish:self];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.text = @"hello";
    
    return cell;
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
