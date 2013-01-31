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
	self.title = NSLocalizedString(@"addTask-TitleLabel", nil);
    NSString *addLabel = NSLocalizedString(@"AddButtonLabel", nil);
    NSString *cancelLabel = NSLocalizedString(@"CancelButtonLabel", nil);
    
    AddTaskView *addTaskView = [[[AddTaskView alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    addTaskView.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:cancelLabel
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(cancel)];
    UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithTitle:addLabel
                                                            style:UIBarButtonSystemItemAdd
                                                           target:self
                                                           action:@selector(add)];
    
    addTaskView.navItem.title = self.title;
    addTaskView.navItem.leftBarButtonItem = cancel;
    addTaskView.navItem.rightBarButtonItem = add;

    self.view = addTaskView;
    
    [cancel release];
    [add release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
