//
//  TodoTextField.h
//  Todo
//
//  Created by Christophe on 04/02/13.
//  Copyright (c) 2013 FuriouZz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodoTextField : UITextField
@property (assign, nonatomic) id <UITextFieldDelegate> delegate;
@end
