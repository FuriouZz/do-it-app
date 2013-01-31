//
//  ViewController.m
//  Todo
//
//  Created by Christophe Massolin on 27/01/13.
//  Copyright (c) 2013 FuriouZz. All rights reserved.
//

#import "TodoListViewController.h"
#import "Task.h"
#import "TaskViewCell.h"

@interface TodoListViewController ()
@property (retain, nonatomic) NSArray *tasks;
@end

@implementation TodoListViewController

- (void)dealloc {
    [_tasks release];
    [super dealloc];
}

- (void)loadTask:(id)sender {        
    self.tasks = [Task loadTasks];
}

#pragma mark - UIViewController

- (void)loadView {
    [super loadView];
    self.title = NSLocalizedString(@"Todo List", nil);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                           target:self
                                                                                           action:@selector(addTask)];
    NSLog(@"%f", self.navigationController.navigationBar.bounds.size.height);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.rowHeight = 70.0f;
    
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
    static NSString *CellIdentifier = @"Cell";
    
    TaskViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[[TaskViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }

    cell.task = [_tasks objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [TaskViewCell heightForCellWithPost:[_tasks objectAtIndex:indexPath.row]];
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
