//
//  NavigationViewController.m
//  Todo
//
//  Created by Christophe on 30/01/13.
//  Copyright (c) 2013 FuriouZz. All rights reserved.
//

#import "NavigationViewController.h"

@interface NavigationViewController ()
@property (retain, nonatomic) UIBarButtonItem *addTask;
@end

@implementation NavigationViewController

- (void)dealloc
{
    [_addTask release];
    [super dealloc];
}

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (id)initWithRootViewController:(UIViewController *) controller
{
    self = [super initWithRootViewController:controller];
    if(self) {
        //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(dealloc)];
    }
    return self;
}

- (void)loadView
{
    //self.navigationController.title = NSLocalizedString(@"Todo List", nil);

    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(dealloc)];
    //self.tableView.rowHeight = 70.0f;
    [super loadView];
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

@end
