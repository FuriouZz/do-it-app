//
//  AddTask.m
//  Todo
//
//  Created by Christophe Massolin on 31/01/13.
//  Copyright (c) 2013 FuriouZz. All rights reserved.
//

#import "AddTaskView.h"
#import "AddTaskViewController.h"

@implementation AddTaskView
@synthesize navBar = _navBar;
@synthesize navItem = _navItem;

-(void)dealloc
{
    [_navBar release];
    [_navItem release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)createView
{
    CGRect navigationRect = [[UIScreen mainScreen] bounds];
    navigationRect.size.height = 44;
    
    self.navBar = [[[UINavigationBar alloc] initWithFrame:navigationRect] autorelease];
    self.navItem = [[[UINavigationItem alloc] initWithTitle:@"Add a task"] autorelease];
    
    [self.navBar pushNavigationItem:self.navItem animated:YES];
    [self addSubview:self.navBar];
    
    UITableView *addTaskForm = [[UITableView alloc] initWithFrame:CGRectMake(10, 60, 200, 40) style:UITableViewStyleGrouped];
    
    UITextField *todo = [[UITextField alloc] initWithFrame:CGRectMake(200, 200, 200, 40)];
    UITextField *note = [[UITextField alloc] initWithFrame:CGRectMake(200, 400, 200, 20)];

    todo.placeholder = @"Entrer un titre";
    todo.backgroundColor = [UIColor grayColor];
    todo.borderStyle = UITextBorderStyleRoundedRect;
    note.placeholder = @"Entrer une description";
    note.backgroundColor = [UIColor grayColor];
    [self addSubview:addTaskForm];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
}
*/
@end
