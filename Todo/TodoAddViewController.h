//
//  AddViewController.h
//  Todo
//
//  Created by Christophe on 02/02/13.
//  Copyright (c) 2013 FuriouZz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Todo.h"
#import "TodoAddViewController.h"

@class TodoAddViewController;

@protocol TodoAddViewControllerDelegate
- (void)todoAddViewControllerDidFinish:(TodoAddViewController *)controller;
@end

@interface TodoAddViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>
@property (assign, nonatomic) id <TodoAddViewControllerDelegate> delegate;
@property (strong, nonatomic) Todo *todo;
@property (retain, nonatomic) UILabel *todoRowLabel;
@property (retain, nonatomic) UILabel *noteRowLabel;
@end
