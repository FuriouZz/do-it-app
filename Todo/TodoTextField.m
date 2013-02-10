//
//  TodoTextField.m
//  Todo
//
//  Created by Christophe on 04/02/13.
//  Copyright (c) 2013 FuriouZz. All rights reserved.
//

#import "TodoTextField.h"

@implementation TodoTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textAlignment = NSTextAlignmentLeft;
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.textColor = [UIColor colorWithRed:0.22 green:0.33 blue:0.53 alpha:1];
        self.font = [UIFont systemFontOfSize:17];
    }
    return self;
}

@end
