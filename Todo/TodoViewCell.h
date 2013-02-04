//
//  TaskViewCell.h
//  Todo
//
//  Created by Christophe Massolin on 27/01/13.
//  Copyright (c) 2013 FuriouZz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Todo;

@interface TodoViewCell : UITableViewCell
@property (nonatomic, retain) Todo *task;

+ (CGFloat)heightForCellWithPost:(Todo *)task;
@end