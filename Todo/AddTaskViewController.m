//
//  AddTaskViewController.m
//  Todo
//
//  Created by Christophe Massolin on 31/01/13.
//  Copyright (c) 2013 FuriouZz. All rights reserved.
//

#import "AddTaskViewController.h"
#import "AddTaskView.h"
#import "TaskViewCell.h"

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
    [super loadView];
	self.title = NSLocalizedString(@"Add Task", nil);

    AddTaskView *myView = [[[AddTaskView alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    myView.backgroundColor = [UIColor whiteColor];
    
    myView.add.action = @selector(add);
    myView.cancel.action = @selector(cancel);
    CGRect navigationRect = [[UIScreen mainScreen] bounds];
    navigationRect.size.height = 44;
    
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:navigationRect];
    UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:self.title];
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(cancel)];
    UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithTitle:@"Add"
                                                            style:UIBarButtonItemStylePlain
                                                           target:self
                                                           action:@selector(add)];
    ////    myView.add.action = @selector(add);
    ////    myView.add.target = self;
    ////    myView.add.style = UIBarButtonItemStylePlain;
    
    navItem.leftBarButtonItem = done;
    navItem.rightBarButtonItem = add;
    [navBar pushNavigationItem:navItem animated:YES];
    
    [myView addSubview:navBar];
    self.view = myView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (void)add
{
    [self.delegate addTaskViewControllerDidFinish:self];
}

- (void)cancel
{
    [self.delegate addTaskViewControllerDidFinish:self];
}

@end
