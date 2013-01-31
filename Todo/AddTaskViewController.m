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
    [super loadView];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.title = NSLocalizedString(@"Add Task", nil);
    
    CGRect viewRect = CGRectMake(40, 40, 50, 100);
    UIView *myView = [[[AddTaskView alloc] initWithFrame:viewRect] autorelease];
    myView.backgroundColor = [UIColor whiteColor];
    
    CGRect navigationRect = [[UIScreen mainScreen] bounds];
    navigationRect.size.height = 44;
    
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:navigationRect];
    UINavigationItem *navItem =[[UINavigationItem alloc] initWithTitle:self.title];
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(cancel)];
    UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithTitle:@"Add"
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(add)];
    navItem.leftBarButtonItem = done;
    navItem.rightBarButtonItem = add;
    [navBar pushNavigationItem:navItem animated:YES];
    
    self.view = myView;
    [self.view addSubview:navBar];
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
