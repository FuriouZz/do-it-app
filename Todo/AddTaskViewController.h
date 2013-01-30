//
//  AddTaskViewController.h
//  Todo
//
//  Created by Christophe Massolin on 31/01/13.
//  Copyright (c) 2013 FuriouZz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddTaskViewController;

@protocol AddTaskViewControllerDelegate
- (void)addTaskViewControllerDidFinish:(AddTaskViewController *)controller;
@end

@interface AddTaskViewController : UIViewController
@property (assign, nonatomic) id <AddTaskViewControllerDelegate> delegate;
@end
