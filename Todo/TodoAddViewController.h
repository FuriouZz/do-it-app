//
//  TodoAddViewController.h
//  Todo
//
//  Created by Christophe on 02/02/13.
//  Copyright (c) 2013 FuriouZz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TodoTextField.h"
#import "TodoTextFieldViewCell.h"

@class TodoAddViewController;

@protocol TodoAddViewControllerDelegate
- (void)insertTodoToList:(Todo *)todo;
- (void)todoAddViewControllerDidFinish:(TodoAddViewController *) controller;
@end

@interface TodoAddViewController : UITableViewController <UITextFieldDelegate>
{
    TodoTextField *titleTextField;
    TodoTextField *noteTextField;
}

@property (assign, nonatomic) id <TodoAddViewControllerDelegate> delegate;
@property (retain, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
