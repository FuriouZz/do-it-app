//
//  TodoAddViewController.m
//  Todo
//
//  Created by Christophe on 02/02/13.
//  Copyright (c) 2013 FuriouZz. All rights reserved.
//

#import "TodoAddViewController.h"
#import "TodoTextFieldViewCell.h"

@interface TodoAddViewController ()
@property (retain, nonatomic) NSArray *attributes;
@property (retain, nonatomic) NSMutableArray *values;
@end

@implementation TodoAddViewController
@synthesize doneButton = _doneButton;
@synthesize cancelButton = _cancelButton;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize navigationBar = _navigationBar;

- (void)dealloc
{
    [_doneButton release];
    [_cancelButton release];
    [_managedObjectContext release];
    [_navigationBar release];
    [super dealloc];
}

- (id)initWithManagedObjectContext:(NSManagedObjectContext *) moc
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
//        self.managedObjectContext = moc;
//        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Todo" inManagedObjectContext:_managedObjectContext];
//        self.attributes = [[entityDescription attributesByName] allKeys];
//        
        self.tableView.scrollEnabled = NO;
        self.attributes = [[NSArray alloc] initWithObjects:@"Your task", @"title", @"Your note", @"note", nil];

        //NSLog(@"%@", self.attributes);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    self.title = NSLocalizedString(@"todoAdd-TitleLabel", nil);
    
    self.doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                    target:self
                                                                    action:@selector(doneAction)];
    self.cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                      target:self
                                                                      action:@selector(cancelAction)];
    self.navigationItem.rightBarButtonItem = self.doneButton;
    self.navigationItem.leftBarButtonItem  = self.cancelButton;

    CGRect navigationRect = [[UIScreen mainScreen] bounds];
    navigationRect.size.height = 44;
    
    self.navigationBar = [[UINavigationBar alloc] initWithFrame:navigationRect];
    
    [self.navigationBar pushNavigationItem:self.navigationItem animated:YES];
    [self.view addSubview:self.navigationBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    TodoTextFieldViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil)
    {
        cell = [[TodoTextFieldViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    cell.attribute = [_attributes objectAtIndex:indexPath.row];
    NSLog(@"%@", cell.attribute);
    
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
#pragma mark - Actions

- (void)doneAction
{
    [self.delegate todoAddViewControllerDidFinish:self];
}

- (void)cancelAction
{
    [self.delegate todoAddViewControllerDidFinish:self];
}

//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    self.title = NSLocalizedString(@"addTask-TitleLabel", nil);
//    NSString *addLabel = NSLocalizedString(@"AddButtonLabel", nil);
//    NSString *cancelLabel = NSLocalizedString(@"CancelButtonLabel", nil);
//    
//    AddTaskView *addTaskView = [[[AddTaskView alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
//    addTaskView.backgroundColor = [UIColor whiteColor];
//    
//    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:cancelLabel
//                                                               style:UIBarButtonItemStylePlain
//                                                              target:self
//                                                              action:@selector(cancel)];
//    UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithTitle:addLabel
//                                                            style:UIBarButtonSystemItemAdd
//                                                           target:self
//                                                           action:@selector(add)];
//    
//    addTaskView.navItem.title = self.title;
//    addTaskView.navItem.leftBarButtonItem = cancel;
//    addTaskView.navItem.rightBarButtonItem = add;
//    
//    [addTaskView addSubview:self.tableView];
//    
//    self.view = addTaskView;
//    
//    [cancel release];
//    [add release];
//    // Uncomment the following line to preserve selection between presentations.
//    // self.clearsSelectionOnViewWillAppear = NO;
//    
//    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
//}
//
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
@end
