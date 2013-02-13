//
//  TodoTextFieldViewCell.m
//  Todo
//
//  Created by Christophe on 03/02/13.
//  Copyright (c) 2013 FuriouZz. All rights reserved.
//

#import "TodoTextFieldViewCell.h"

@implementation TodoTextFieldViewCell
@synthesize textField = _textField;

-(void)dealloc
{
    safeRelease(_textField);
    
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect origFrame = self.contentView.frame;
    _textField.frame = CGRectMake(origFrame.origin.x, origFrame.origin.y, origFrame.size.width-20, origFrame.size.height-1);
    
    [self setNeedsDisplay];
}

- (void)setTextField:(TodoTextField *)textField
{
    _textField = textField;
    [self.contentView addSubview:_textField];
}

#pragma mark - TextField Delegate

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

@end
