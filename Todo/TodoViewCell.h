//
//  TaskViewCell.h
//  Todo
//
//  Created by Christophe Massolin on 27/01/13.
//  Copyright (c) 2013 FuriouZz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckboxView.h"

@class Todo;
@class CheckboxView;

@interface TodoViewCell : UITableViewCell {
    UIImage *checkboxImage;
}
@property (nonatomic, assign) BOOL isMarked;
@property (nonatomic, retain) Todo *todo;
@property (nonatomic, retain) CheckboxView *checkboxView;

+ (CGFloat)heightForCellWithPost:(Todo *)task;
@end
