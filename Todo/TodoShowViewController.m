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
    [_managedObjectContext release];
    [_addButton release];
    [_todosArray release];
    [super dealloc];
}

#pragma mark - UIViewController

- (void)loadView {
    [super loadView];
    
    // Titre de la vue
    self.title = NSLocalizedString(@"todoShow-TitleLabel", nil);
    
    // Boutons de la barre de navigation
    _addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                target:self
                                                                action:@selector(addEvent)];
    self.navigationItem.rightBarButtonItem = _addButton;
    
    // Libération mémoire
    [_addButton release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.rowHeight = 50.0f;
   // self.todosArray = [[NSMutableArray alloc] init];
    
    // Définition de la requête
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    // Définition de l'entité à récupérer
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Todo" inManagedObjectContext:_managedObjectContext];
    [request setEntity:entity];
    
    // Définition des règles de tris
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"createdAt" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptors];
    [sortDescriptors release];
    [sortDescriptor release];
    
    // Execution de la requête
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[_managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResults == nil) {
        // Handle the error.
    }

    self.todosArray = mutableFetchResults;
    [mutableFetchResults release];
    [request release];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
    self.addButton = nil;
    self.todosArray = nil;
}


#pragma mark - UITableViewDataSource

// Retourne le nombre de tâche
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_todosArray count];
}

// Retourne une cellule avec toutes les informations
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    TodoViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[TodoViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }

    cell.task = (Todo *)[_todosArray objectAtIndex:indexPath.row];
    return cell;


//    // Dequeue or create a new cell.
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
//    }
//    
//    Todo *todo = (Todo *)[_todosArray objectAtIndex:indexPath.row];
//    cell.textLabel.text = todo.title;
//    cell.detailTextLabel.text = todo.note;
//    
//    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [TodoViewCell heightForCellWithPost:[_todosArray objectAtIndex:indexPath.row]];
}

// Quand une cellule est selectionnée, le fond gris disparait
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - AddTaskViewDelegate

- (void)addEvent
{
    // Create and configure a new instance of the "Todo" entity.
    Todo *todo = (Todo *)[NSEntityDescription insertNewObjectForEntityForName:@"Todo" inManagedObjectContext:_managedObjectContext];

    todo.title = @"Ma tâche est là !";
    todo.note  = @"Encore une nouvelle tâche de la mort à ne surtout pas rater.";
    todo.createdAt = todo.updatedAt = [NSDate date];
    
    NSError *error = nil;
    if(![_managedObjectContext save:&error])
    {
        // Envoyer une erreur
    }
    
    [_todosArray insertObject:todo atIndex:0];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)addTask
{
    TodoAddViewController *controller = [[[TodoAddViewController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
    controller.delegate = self;
    controller.modalTransitionStyle =  UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)todoAddViewControllerDidFinish:(TodoAddViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
