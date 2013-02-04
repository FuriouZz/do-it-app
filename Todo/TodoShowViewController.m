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
                                                                action:@selector(addTodo)];
    self.navigationItem.rightBarButtonItem = _addButton;
    
    // Libération mémoire
    [_addButton release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.rowHeight = 50.0f;

    [self loadTodos];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
    self.addButton = nil;
    self.todosArray = nil;
}

#pragma mark - Own Methods
- (void)loadTodos
{
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
    
    // Libération de la mémoire
    [mutableFetchResults release];
    [request release];
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
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSManagedObject *todo = [_todosArray objectAtIndex:indexPath.row];
        
        // Suppression de l'entrée du contexte
        [_managedObjectContext deleteObject:todo];
        
        // Suppression de l'entrée du tableau et de la vue
        [_todosArray removeObject:todo];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
 
        // Enregistrement en BDD
        NSError *error = nil;
        if(![_managedObjectContext save:&error])
        {
            // Envoyer une erreur
        }        
    }
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

- (void)addTodo
{
    TodoAddViewController *controller = [[[TodoAddViewController alloc] initWithManagedObjectContext:self.managedObjectContext] autorelease];
    controller.delegate = self;
    controller.modalTransitionStyle =  UIModalTransitionStyleCoverVertical;
    
    UINavigationController *navController = [[[UINavigationController alloc] initWithRootViewController:controller] autorelease];
    
    [self presentViewController:navController animated:YES completion:nil];
}

- (void)createTodo:(NSArray *)values
{
    // Déclaration de la nouvelle tâche et enregistrement dans le contexte
    Todo *todo = (Todo *)[NSEntityDescription insertNewObjectForEntityForName:@"Todo" inManagedObjectContext:_managedObjectContext];
    
    todo.title = @"Ma tâche est là !";
    todo.note  = @"Encore une nouvelle tâche de la mort à ne surtout pas rater.";
    todo.createdAt = todo.updatedAt = [NSDate date];
    
    // Malgré que l'objet soit créé, il n'est encore enregistré dans la BDD.
    // La tâche est déjà enregistrée dans le contexte. Mais le contexte lui ne l'est pas encore.
    NSError *error = nil;
    if(![_managedObjectContext save:&error])
    {
        // Envoyer une erreur
    }
    
    // L'insérer dans la tableau et actualiser la liste avec la nouvelle entrée
    [_todosArray insertObject:todo atIndex:0];
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)todoAddViewControllerDidFinish:(TodoAddViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
