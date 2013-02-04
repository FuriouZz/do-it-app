//
//  TodoTextFieldViewCell.h
//  Todo
//
//  Created by Christophe on 03/02/13.
//  Copyright (c) 2013 FuriouZz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TodoTextField.h"

@interface TodoTextFieldViewCell : UITableViewCell <UITextFieldDelegate>
@property (retain, nonatomic) TodoTextField *textField;
@end
