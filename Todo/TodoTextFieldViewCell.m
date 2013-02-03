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
@synthesize attribute = _attribute;

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
        [self.contentView addSubview:_textField];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect origFrame = self.contentView.frame;
    if(_textField.text != nil)
    {
        _textField.hidden = NO;
        _textField.frame = CGRectMake(origFrame.origin.x, origFrame.origin.y, 125, origFrame.size.height-1);
	} else {
		_textField.hidden = YES;
		_textField.frame = CGRectMake(origFrame.origin.x+10, origFrame.origin.y, origFrame.size.width-20, origFrame.size.height-1);
	}
    
    [self setNeedsDisplay];
}

- (void)setAttribute:(NSObject *)attribute
{
    _attribute = attribute;
    //NSLog(@"%@", _attribute);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
