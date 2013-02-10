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
        self.tableView.scrollEnabled = NO;
        
        titleTextField = [[TodoTextField alloc] initWithFrame:CGRectMake(0, 100, 0, 0)];
        titleTextField.placeholder = @"Your title";
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

    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                target:self
                                                                                action:@selector(doneAction)];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                  target:self
                                                                                  action:@selector(cancelAction)];
    self.title = NSLocalizedString(@"todoAdd-TitleLabel", nil);
    self.navigationItem.rightBarButtonItem = doneButton;
    self.navigationItem.leftBarButtonItem  = cancelButton;
    
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Actions

- (void)doneAction
{
    // Déclaration de la nouvelle tâche et enregistrement dans le contexte
    Todo *todo = (Todo *)[NSEntityDescription insertNewObjectForEntityForName:@"Todo" inManagedObjectContext:_managedObjectContext];
    
    todo.title = titleTextField.text;
    todo.note  = noteTextField.text;
    todo.createdAt = todo.updatedAt = [NSDate date];
    todo.isChecked = [NSNumber numberWithBool:NO];
    
    // Malgré que l'objet soit créé, il n'est encore enregistré dans la BDD.
    // La tâche est déjà enregistrée dans le contexte. Mais le contexte lui ne l'est pas encore.
    NSError *error = nil;
    if(![_managedObjectContext save:&error])
    {
        NSLog(@"%@", error);
    }
    
    [self.delegate insertTodoToList:todo];
    [self.delegate todoAddViewControllerDidFinish:self];
}

- (void)cancelAction
{
    [self.delegate todoAddViewControllerDidFinish:self];
}

@end
