//
//  TodoTextFieldViewCell.h
//  Todo
//
//  Created by Christophe on 03/02/13.
//  Copyright (c) 2013 FuriouZz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TodoTextFieldViewCell;

@protocol TodoTextFieldViewCellDelegate <NSObject>

@optional
//Called to the delegate whenever return is hit when a user is typing into the rightTextField of an SDTextFieldCell
- (BOOL)textFieldCell:(TodoTextFieldViewCell *)inCell shouldReturnForIndexPath:(NSIndexPath*)inIndexPath withValue:(NSString *)inValue;

//Called to the delegate whenever the text in the textField is changed
- (void)textFieldCell:(TodoTextFieldViewCell *)inCell updateTextLabelAtIndexPath:(NSIndexPath *)inIndexPath string:(NSString *)inValue;
@end

@interface TodoTextFieldViewCell : UITableViewCell <UITextFieldDelegate>
@property (assign, nonatomic) id <TodoTextFieldViewCellDelegate> delegate;
@property (retain, nonatomic) UITextField *textField;
@property (retain, nonatomic) NSDictionary *attribute;
@property (retain, nonatomic) NSIndexPath *indexPath;
@end
