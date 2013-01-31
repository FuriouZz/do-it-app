//
//  ViewController.m
//  Todo
//
//  Created by Christophe Massolin on 27/01/13.
//  Copyright (c) 2013 FuriouZz. All rights reserved.
//

#import "TodoListViewController.h"
#import "Todo.h"
#import "TodoViewCell.h"

@interface TodoListViewController ()
@property (retain, nonatomic) NSArray *tasks;
@end

@implementation TodoListViewController
@synthesize tasks = _tasks;

- (void)dealloc {
    [_tasks release];
    [super dealloc];
}

- (void)loadTask:(id)sender {
    if(!self.tasks)
        self.tasks = [Todo loadTasks];
}

#pragma mark - UIViewController

- (void)loadView {
    [super loadView];
    self.title = NSLocalizedString(@"todoList-TitleLabel", nil);
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                           target:self
                                                                                           action:@selector(addTask)] autorelease];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.rowHeight = 50.0f;
    
    [self loadTask:nil];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

#pragma mark - UITableViewDataSource

// Retourne le nombre de tâche
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_tasks count];
}

// Retourne une cellule avec toutes les informations
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TodoViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[[TodoViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"] autorelease];
    }

    cell.task = [_tasks objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [TodoViewCell heightForCellWithPost:[_tasks objectAtIndex:indexPath.row]];
}

// Quand une cellule est selectionnée, le fond gris disparait
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - AddTaskViewDelegate

- (void)addTask
{
    AddTaskViewController *controller = [[[AddTaskViewController alloc] init] autorelease];
    controller.delegate = self;
    controller.modalTransitionStyle =  UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)addTaskViewControllerDidFinish:(AddTaskViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
