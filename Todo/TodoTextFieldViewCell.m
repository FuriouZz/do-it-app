//
//  TodoTextFieldViewCell.m
//  Todo
//
//  Created by Christophe on 03/02/13.
//  Copyright (c) 2013 FuriouZz. All rights reserved.
//

#import "TodoTextFieldViewCell.h"

@implementation TodoTextFieldViewCell
@synthesize delegate = _delegate;
@synthesize textField = _textField;
@synthesize attribute = _attribute;

-(void)dealloc
{
    [_delegate release];
    [_attribute release];
    [_textField release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 100, 0, 0)];
        _textField.textAlignment = NSTextAlignmentLeft;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _textField.textColor = [UIColor colorWithRed:0.22 green:0.33 blue:0.53 alpha:1];
        [_textField setFont:[UIFont systemFontOfSize:17]];
        _textField.delegate = self;
        
        [self.contentView addSubview:_textField];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect origFrame = self.contentView.frame;
    _textField.hidden = NO;
    _textField.frame = CGRectMake(origFrame.origin.x, origFrame.origin.y, origFrame.size.width-20, origFrame.size.height-1);
    
    [self setNeedsDisplay];
}

- (void)setAttribute:(NSDictionary *)attribute
{
    _attribute = attribute;
    _textField.placeholder = [_attribute objectForKey:@"label"];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    BOOL ret = YES;
	if([_delegate respondsToSelector:@selector(textFieldCell:shouldReturnForIndexPath:withValue:)]) {
        NSLog(@"test");
        ret = [_delegate textFieldCell:self shouldReturnForIndexPath:_indexPath withValue:self.textField.text];
	}
    if(ret) {
        [textField resignFirstResponder];
    }
    return ret;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	NSString *textString = self.textField.text;
	textString = [textString stringByReplacingCharactersInRange:range withString:string];

	if([_delegate respondsToSelector:@selector(textFieldCell:updateTextLabelAtIndexPath:string:)]) {
		[_delegate textFieldCell:self updateTextLabelAtIndexPath:_indexPath string:textString];
	}
    
	return YES;
}

@end
