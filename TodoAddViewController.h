//
//  TodoAddViewController.h
//  Todo
//
//  Created by Christophe on 02/02/13.
//  Copyright (c) 2013 FuriouZz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TodoAddViewController;

@protocol TodoAddViewControllerDelegate
- (void) todoAddViewControllerDidFinish:(TodoAddViewController *) controller;
@end

@interface TodoAddViewController : UITableViewController
@property (assign, nonatomic) id <TodoAddViewControllerDelegate> delegate;
@property (retain, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (retain, nonatomic) UIBarButtonItem *doneButton;
@property (retain, nonatomic) UIBarButtonItem *cancelButton;
@property (retain, nonatomic) UINavigationBar *navigationBar;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *) moc;
@end
