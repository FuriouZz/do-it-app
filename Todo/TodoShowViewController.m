//
//  ViewController.m
//  Todo
//
//  Created by Christophe Massolin on 27/01/13.
//  Copyright (c) 2013 FuriouZz. All rights reserved.
//

#import "TodoShowViewController.h"
#import "TodoViewCell.h"

@interface TodoShowViewController ()

@end

@implementation TodoShowViewController
@synthesize managedObjectContext = _managedObjectContext;
@synthesize todosArray = _todosArray;
@synthesize addButton = _addButton;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // My initialization code
    }
    return self;
}

- (void)dealloc {
    safeRelease(_managedObjectContext);
    safeRelease(_addButton);
    safeRelease(_todosArray);
    
    [super dealloc];
}

#pragma mark - UIViewController

- (void)loadView {
    [super loadView];
    self.title = NSLocalizedString(@"todoShow-TitleLabel", nil);    // Title view
    // Add button
    _addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                target:self
                                                                action:@selector(addButtonAction)];
    // Place the button on the right position on the navigation bar
    self.navigationItem.rightBarButtonItem = _addButton;

    [_addButton release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadTodos];       // Load datas
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
    self.addButton = nil;
    self.todosArray = nil;
}

#pragma mark - UITableViewDataSource
// Define the number of rows in a section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_todosArray count];
}

// Define the cell for a row. Here, you fill your cell with datas of the todosArray
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    TodoViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[TodoViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        // Define the tap gesture recognizer on the CheckboxView
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeMarkStateOnTap:)];
//        [cell.checkboxView addGestureRecognizer:tap];
//        [tap release];
    }
    
    // Place data to the cell
    cell.todo = [_todosArray objectAtIndex:indexPath.row];
    cell.checkboxView.delegate = self;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Action when you want to delete a todo
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Get the object
        NSManagedObject *todo = [_todosArray objectAtIndex:indexPath.row];
        
        // Delete the object in the todosArray and the row in the tableView
        [_todosArray removeObject:todo];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
        
        // Delete the object in the ManagedObjectContext
        [_managedObjectContext deleteObject:todo];
        
        // Delete the object in the database
        [_managedObjectContext save:nil];
    }
}

#pragma mark - UITableViewDelegate
// Define the height for row
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [TodoViewCell heightForCellWithPost:[_todosArray objectAtIndex:indexPath.row]];
}

#pragma mark - Own Methods
// Load datas
- (void)loadTodos
{
    // Declare the request
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    // Declare the entity
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Todo" inManagedObjectContext:_managedObjectContext];
    [request setEntity:entity];
    
    // Declare some rules
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"createdAt" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptors];
    [sortDescriptors release];
    [sortDescriptor release];
    
    // Execute the request
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[_managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResults == nil) {
        NSLog(@"No result found.");
    }
    
    // Fill the array with datas
    self.todosArray = mutableFetchResults;
    
    [mutableFetchResults release];
    [request release];
}

#pragma mark - Actions
// Add button action
- (void) addButtonAction
{
    // Define the TodoAddViewController
    TodoAddViewController *controller = [[[TodoAddViewController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
    controller.delegate = self;
    controller.managedObjectContext = _managedObjectContext;
    controller.modalTransitionStyle =  UIModalTransitionStyleCoverVertical;
    
    // Load the TodoAddViewController with a navigation bar and all the functions of the UINavigationController
    UINavigationController *navController = [[[UINavigationController alloc] initWithRootViewController:controller] autorelease];
    
    // Open the controller with an animation
    [self presentViewController:navController animated:YES completion:nil];
}

// Checkbox action
//- (void) changeMarkStateOnTap:(UITapGestureRecognizer *)tapRecognizer {
//    CGPoint tapLocation = [tapRecognizer locationInView:self.tableView];                // Get the touch position
//    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:tapLocation];       // Get the indexPath of the row in this touch position (Genious!)
//    NSLog(@"%ld", (long)indexPath.row);
//    NSManagedObject *todo = [_todosArray objectAtIndex:indexPath.row];                  // Get the managed object
//    
//    BOOL checkValue = ![[todo valueForKey:@"isChecked"] boolValue];                     // Toggle the value
//    [todo setValue:[NSNumber numberWithBool:checkValue] forKey:@"isChecked"];           // Change the value
//    
//    [_managedObjectContext save:nil];                                                   // Update the data in DB
//    
//    // Reload the row with updated datas
//    [self.tableView reloadData];
//    //[self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
//}

- (void) changeMarkStateOnTap:(id)anyObject
{
    CGPoint tapLocation = [anyObject locationInView:self.tableView];                    // Get the touch position
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:tapLocation];       // Get the indexPath of the row in this touch position (Genious!)
    
    NSManagedObject *todo = [_todosArray objectAtIndex:indexPath.row];                  // Get the managed object
    
    BOOL checkValue = ![[todo valueForKey:@"isChecked"] boolValue];                     // Toggle the value
    [todo setValue:[NSNumber numberWithBool:checkValue] forKey:@"isChecked"];           // Change the value
    
    [_managedObjectContext save:nil];                                                   // Update the data in DB
    
    // Reload the row with updated datas
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

}

#pragma mark - TodoAddViewDelegate
- (void)insertTodoToList:(Todo *)todo
{
    [_todosArray insertObject:todo atIndex:0];      // Insert the todo in the array
    
    // Insert the new todo in the top of the tableView and scroll to the top.
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

// Close the TodoAddView
- (void)todoAddViewControllerDidFinish:(TodoAddViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
