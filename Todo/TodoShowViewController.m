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

    cell.task = [_todosArray objectAtIndex:indexPath.row];
    cell.checkboxView.indexPath = indexPath;
    cell.checkboxView.delegate = self;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSManagedObject *todo = [_todosArray objectAtIndex:indexPath.row];
        
        // Suppression de l'entrée du tableau et de la vue
        [_todosArray removeObject:todo];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
        
        // Suppression de l'entrée du contexte
        [_managedObjectContext deleteObject:todo];
        
        // Enregistrement en BDD
        NSError *error = nil;
        if(![_managedObjectContext save:&error])
        {
            NSLog(@"%@", error);
        }        
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [TodoViewCell heightForCellWithPost:[_todosArray objectAtIndex:indexPath.row]];
}

// Quand je sélectionne une cellule, je change son état
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"Selected");
//}
-(void)changeMarkStateAtIndexPath:(NSIndexPath *)indexPath {
    NSManagedObject *todo = [_todosArray objectAtIndex:indexPath.row];
    
    BOOL checkValue = ![[todo valueForKey:@"isChecked"] boolValue];
    [todo setValue:[NSNumber numberWithBool:checkValue] forKey:@"isChecked"];
    
    [_managedObjectContext save:nil];
    
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - AddTaskViewDelegate

- (void)addTodo
{
    TodoAddViewController *controller = [[[TodoAddViewController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
    controller.delegate = self;
    controller.managedObjectContext = _managedObjectContext;
    controller.modalTransitionStyle =  UIModalTransitionStyleCoverVertical;
    
    UINavigationController *navController = [[[UINavigationController alloc] initWithRootViewController:controller] autorelease];
    
    [self presentViewController:navController animated:YES completion:nil];
}

- (void)insertTodoToList:(Todo *)todo
{
    // Insérer la todo dans la tableau et actualiser la liste avec la nouvelle entrée
    [_todosArray insertObject:todo atIndex:0];
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)todoAddViewControllerDidFinish:(TodoAddViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
