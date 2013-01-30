//
//  TaskViewCell.h
//  Todo
//
//  Created by Christophe Massolin on 27/01/13.
//  Copyright (c) 2013 FuriouZz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Task;

@interface TaskViewCell : UITableViewCell
@property (retain, nonatomic) Task *task;

+ (CGFloat)heightForCellWithPost:(Task *)task;
@end
