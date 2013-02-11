//
//  TodoAddViewController.m
//  Todo
//
//  Created by Christophe on 02/02/13.
//  Copyright (c) 2013 FuriouZz. All rights reserved.
//

#import "Todo.h"
#import "TodoAddViewController.h"
#import "TodoTextFieldViewCell.h"

@implementation TodoAddViewController
@synthesize managedObjectContext = _managedObjectContext;

- (void)dealloc
{
    [_managedObjectContext release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.tableView.scrollEnabled = NO;      // Disable scroll
        
        // Declare textfields that I want to see
        titleTextField = [[TodoTextField alloc] initWithFrame:CGRectMake(0, 100, 0, 0)];
        titleTextField.placeholder = @"Your title*";
        titleTextField.delegate = self;
        
        noteTextField = [[TodoTextField alloc] initWithFrame:CGRectMake(0, 100, 0, 0)];
        noteTextField.placeholder = @"Your note";
        noteTextField.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"todoAdd-TitleLabel", nil);     // Title view
    
    // Create done and cancel buttons
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                target:self
                                                                                action:@selector(doneButtonAction)];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                  target:self
                                                                                  action:@selector(cancelButtonAction)];
    // Place buttons in the navigation bar
    self.navigationItem.rightBarButtonItem = doneButton;
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.navigationItem.leftBarButtonItem  = cancelButton;
    
    // Test if textfields are not empty when the keyword will hide
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(testRequiredField) name:UIKeyboardWillHideNotification object:nil];
    
    [doneButton release];
    [cancelButton release];
    
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

    switch(indexPath.row)
    {
        case 0:
            cell.textField = titleTextField;
            break;
        case 1:
            cell.textField = noteTextField;
            break;
        default:
            cell.textField = [[[TodoTextField alloc] initWithFrame:CGRectZero] autorelease];
            break;
    }

    return cell;
}

#pragma mark - UITextFieldDelegate
// When you press the return button in the keyboard, the textfield resignFirstResponder and the keyboard hide
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Methods

// Test textfields
- (void)testRequiredField
{
    if([titleTextField.text length] > 0)
        self.navigationItem.rightBarButtonItem.enabled = YES;
    else
        self.navigationItem.rightBarButtonItem.enabled = NO;
}

#pragma mark - Actions

- (void)doneButtonAction
{
    // Declare the new todo and its context
    Todo *todo = (Todo *)[NSEntityDescription insertNewObjectForEntityForName:@"Todo" inManagedObjectContext:_managedObjectContext];
    
    // Fill the object with the data
    todo.title = titleTextField.text;
    todo.note  = noteTextField.text;
    todo.createdAt = todo.updatedAt = [NSDate date];
    todo.isChecked = [NSNumber numberWithBool:NO];
    
    // Malgré que l'objet soit créé, il n'est encore enregistré dans la BDD.
    // La tâche est déjà enregistrée dans le contexte. Mais le contexte lui ne l'est pas encore.
    
    // The object is in the managedContext, but not save in the DB.
    // You need to do (if you don't want catch error) : [_managedObjectContext save:nil];
    
    NSError *error = nil;
    if(![_managedObjectContext save:&error])
    {
        NSLog(@"%@", error);
    }
    [error release];
    
    // Send the todo to the delegate and close the TodoAddView
    [self.delegate insertTodoToList:todo];
    [self.delegate todoAddViewControllerDidFinish:self];
}

- (void)cancelButtonAction
{
    [self.delegate todoAddViewControllerDidFinish:self];
}

@end
