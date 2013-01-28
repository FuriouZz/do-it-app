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
- (void)loadTask:(id)sender;
@end

@implementation TodoListViewController {
@private
    __strong NSArray *_tasks;
}

- (void)loadTask:(id)sender {
    NSMutableArray *mutableTasks = [[NSMutableArray alloc] init];
    
    Task *task1 = [[Task alloc] initWithAttributes:[[NSDictionary alloc] initWithObjectsAndKeys:
                                                    @"Banane", @"title", @"Description de la mort", @"description", nil]];
    Task *task2 = [[Task alloc] initWithAttributes:[[NSDictionary alloc] initWithObjectsAndKeys:
                                                    @"Banane 2", @"title", @"Les bananes c'est bon, il faut en manger jour ET nuit.", @"description", nil]];
    Task *task3 = [[Task alloc] initWithAttributes:[[NSDictionary alloc] initWithObjectsAndKeys:
                                                    @"Banane", @"title", @"Description de la mort", @"description", nil]];
    Task *task4 = [[Task alloc] initWithAttributes:[[NSDictionary alloc] initWithObjectsAndKeys:
                                                    @"Banane 2", @"title", @"Les bananes c'est bon, il faut en manger jour ET nuit.", @"description", nil]];
    Task *task5 = [[Task alloc] initWithAttributes:[[NSDictionary alloc] initWithObjectsAndKeys:
                                                    @"Banane", @"title", @"Description de la mort", @"description", nil]];
    Task *task6 = [[Task alloc] initWithAttributes:[[NSDictionary alloc] initWithObjectsAndKeys:
                                                    @"Banane 2", @"title", @"Les bananes c'est bon, il faut en manger jour ET nuit.", @"description", nil]];
    Task *task7 = [[Task alloc] initWithAttributes:[[NSDictionary alloc] initWithObjectsAndKeys:
                                                    @"Banane", @"title", @"Description de la mort", @"description", nil]];
    Task *task8 = [[Task alloc] initWithAttributes:[[NSDictionary alloc] initWithObjectsAndKeys:
                                                    @"Banane 2", @"title", @"Les bananes c'est bon, il faut en manger jour ET nuit.", @"description", nil]];
    Task *task9 = [[Task alloc] initWithAttributes:[[NSDictionary alloc] initWithObjectsAndKeys:
                                                    @"Banane", @"title", @"Description de la mort", @"description", nil]];
    Task *task10 = [[Task alloc] initWithAttributes:[[NSDictionary alloc] initWithObjectsAndKeys:
                                                    @"Banane 2", @"title", @"Les bananes c'est bon, il faut en manger jour ET nuit.", @"description", nil]];
    
    [mutableTasks addObjectsFromArray:[NSArray arrayWithObjects:task1, task2, task3, task4, task5, task6, task7, task8, task9, task10, nil]];
    
    _tasks = [NSArray arrayWithArray:mutableTasks];
    
    [task1 release];
    [task2 release];
    [task3 release];
    [task4 release];
    [task5 release];
    [task6 release];
    [task7 release];
    [task8 release];
    [task9 release];
    [task10 release];
    
    [mutableTasks release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_tasks release];
    [super dealloc];
}

#pragma mark - UIViewController

- (void)loadView {
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Todo List", nil);
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
        cell = [[TaskViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.task = [_tasks objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [TaskViewCell heightForCellWithPost:[_tasks objectAtIndex:indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
