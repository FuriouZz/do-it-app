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
@synthesize add = _add;
@synthesize cancel = _cancel;

-(void)dealloc
{
    [_navBar release];
    [_navItem release];
    [_add release];
    [_cancel release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //[self createView];
    }
    return self;
}

- (void)createView
{
    CGRect navigationRect = [[UIScreen mainScreen] bounds];
    navigationRect.size.height = 44;
    
    self.navBar = [[UINavigationBar alloc] initWithFrame:navigationRect];
    self.navItem = [[UINavigationItem alloc] initWithTitle:@"Test"];
    self.cancel = [[UIBarButtonItem alloc] init];
//    self.cancel = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
//                                                   style:UIBarButtonItemStylePlain
//                                                  target:self
//                                                  action:@selector(cancel)];
    self.add = [[UIBarButtonItem alloc] init];
//    self.add = [[UIBarButtonItem alloc] initWithTitle:@"Add"
//                                                style:UIBarButtonItemStylePlain
//                                               target:self
//                                               action:@selector(add)];
    
    self.navItem.leftBarButtonItem = self.cancel;
    self.navItem.rightBarButtonItem = self.add;
    [self.navBar pushNavigationItem:self.navItem animated:YES];
    
    [self addSubview:self.navBar];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
}
*/
@end
