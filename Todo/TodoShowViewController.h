//
//  ViewController.h
//  Todo
//
//  Created by Christophe Massolin on 27/01/13.
//  Copyright (c) 2013 FuriouZz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Todo.h"
#import "TodoAddViewController.h"

@interface TodoShowViewController : UITableViewController <TodoAddViewControllerDelegate>
@property (retain, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (retain, nonatomic) NSMutableArray *todosArray;
@property (retain, nonatomic) UIBarButtonItem *addButton;

- (void)addEvent;
@end
