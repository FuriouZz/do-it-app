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

@end

@implementation TodoListViewController {

@private
    NSArray *_tasks;
}

- (void)loadTask
{
    NSMutableArray *mutableTasks = [NSMutableArray arrayWithCapacity:10];
    
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
    [mutableTasks addObject:task1];
    [mutableTasks addObject:task2];
    [mutableTasks addObject:task3];
    [mutableTasks addObject:task4];
    [mutableTasks addObject:task5];
    [mutableTasks addObject:task6];
    [mutableTasks addObject:task7];
    [mutableTasks addObject:task8];
    [mutableTasks addObject:task9];
    [mutableTasks addObject:task10];
    
    _tasks = mutableTasks;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.title = NSLocalizedString(@"Todo List", nil);
    self.tableView.rowHeight = 70.0f;
    
    [self loadTask];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

// Retourne le nombre de tâche
- (NSInteger)tableView:(UITableView *) tableView numberOfRowsInSection:(NSInteger)section
{
    return [_tasks count];
}

// Retourne une cellule avec toutes les informations
- (UITableViewCell *)tableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
