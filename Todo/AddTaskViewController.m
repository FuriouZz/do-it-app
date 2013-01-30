//
//  AddTaskViewController.m
//  Todo
//
//  Created by Christophe Massolin on 31/01/13.
//  Copyright (c) 2013 FuriouZz. All rights reserved.
//

#import "AddTaskViewController.h"
#import "AddTaskView.h"

@interface AddTaskViewController ()

@end

@implementation AddTaskViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)loadView
{
    CGRect viewRect = CGRectMake(40, 40, 50, 100);
    UIView *myView = [[AddTaskView alloc] initWithFrame:viewRect];
    myView.backgroundColor = [UIColor redColor];
    self.view = myView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.title = NSLocalizedString(@"Add Task", nil);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (void)addTask
{
    [self.delegate addTaskViewControllerDidFinish:self];
}

- (void)cancelAddTask
{
    [self.delegate addTaskViewControllerDidFinish:self];
}

@end
