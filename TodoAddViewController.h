//
//  TodoAddViewController.h
//  Todo
//
//  Created by Christophe on 02/02/13.
//  Copyright (c) 2013 FuriouZz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TodoTextFieldViewCell.h"

@class TodoAddViewController;

@protocol TodoAddViewControllerDelegate
- (void) todoAddViewControllerDidFinish:(TodoAddViewController *) controller;
@end

@interface TodoAddViewController : UITableViewController <TodoTextFieldViewCellDelegate>
@property (assign, nonatomic) id <TodoAddViewControllerDelegate> delegate;
@property (retain, nonatomic) NSManagedObjectContext *managedObjectContext;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *) moc;
@end
