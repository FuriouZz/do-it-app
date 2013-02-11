//
//  TaskViewCell.m
//  Todo
//
//  Created by Christophe Massolin on 27/01/13.
//  Copyright (c) 2013 FuriouZz. All rights reserved.
//

#import "TodoViewCell.h"
#import "Todo.h"

#define checkboxSize        CGSizeMake(50.0, 69.0)
#define checkboxMargin      10
#define checkboxBoxWidth    checkboxSize.width + checkboxMargin


@implementation TodoViewCell
@synthesize textLabel = _label;
@synthesize detailTextLabel = _detailLabel;
@synthesize todo = _todo;
@synthesize isMarked = _isMarked;
@synthesize checkboxView = _checkboxView;

- (void)dealloc {
    [checkboxImage release];
    [_checkboxView release];
    [_label release];
    [_detailLabel release];
    [_todo release];
    [super dealloc];
}

// Définition du style de la cellule à l'initialisation de l'object
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Configure label
        _label = [[UILabel alloc] initWithFrame:CGRectMake(checkboxBoxWidth, .0, self.frame.size.width-checkboxBoxWidth, self.frame.size.height)];
        _label.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_label];
        
        // Configure detailLabel
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(checkboxBoxWidth, _label.frame.size.height, self.frame.size.width-checkboxBoxWidth, 12)];
        _detailLabel.textColor = [UIColor darkGrayColor];
        _detailLabel.font = [UIFont systemFontOfSize:12.0f];
        _detailLabel.numberOfLines = 0;
        [self.contentView addSubview:_detailLabel];
        
        // Configure checkboxView
        _checkboxView = [UIImageView new];
        _checkboxView.userInteractionEnabled = YES;
        [self.contentView addSubview:_checkboxView];
        checkboxImage = [self renderMark];
        
        // Others configurations
        self.selectionStyle = UITableViewCellStyleDefault;        // Style de la cellule à la selection
    }
    
    return self;
}

// Set task
- (void)setTodo:(Todo *)todo {
    _todo = todo;

    self.textLabel.text = _todo.title;
    self.detailTextLabel.text = _todo.note;
    _isMarked = _todo.isChecked.boolValue;
    _checkboxView.image = (_isMarked) ? checkboxImage : nil;
}

// Défini la taille des cellules
+ (CGFloat)heightForCellWithPost:(Todo *)task {
    CGSize sizeToFit = [task.note sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(220.0f, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    
    return fmaxf(70.0f, sizeToFit.height + 45.0f);
}

//#pragma mark - UIView
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated
//{
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

- (void)drawRect:(CGRect)rect
{
    _checkboxView.frame = CGRectMake(0, 0, checkboxSize.width, checkboxSize.height);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // Dessine la checkbox
    CGContextSaveGState(ctx);
    {
        CGContextSetRGBStrokeColor(ctx, 224/255.0, 224/255.0, 224/255.0, 1.0);
        CGContextSetLineWidth(ctx, 5.0);
        CGContextMoveToPoint(ctx, 36.0, 27);
        CGContextAddLineToPoint(ctx, 22, 41.0);
        CGContextAddLineToPoint(ctx, 14.0, 33.0);
        CGContextSetShouldAntialias(ctx, YES);
        CGContextStrokePath(ctx);
    }
    CGContextRestoreGState(ctx);
    
    // Dessine la délimitation à droite
    CGContextSetRGBStrokeColor(ctx, 224/255.0, 224/255.0, 224/255.0, 1.0);
    CGContextSetLineWidth(ctx, 1.0);
    CGContextMoveToPoint(ctx, checkboxSize.width, .0);
    CGContextAddLineToPoint(ctx, checkboxSize.width, checkboxSize.height);
    CGContextSetShouldAntialias(ctx, NO);
    CGContextStrokePath(ctx);
    
    [super drawRect:rect];
}

- (UIImage *)renderMark
{
    // Définition du conteneur qui contiendra le dessin
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
        UIGraphicsBeginImageContextWithOptions(checkboxSize, NO, [UIScreen mainScreen].scale);
    else
        UIGraphicsBeginImageContext(checkboxSize);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // Dessine l'arrière-plan
    CGContextSaveGState(ctx);
    {
        CGContextSetRGBFillColor(ctx, 42/255.0, 197/255.0, .0, 1.0);
        CGContextFillRect(ctx, CGRectMake(0, 0, checkboxSize.width+5, checkboxSize.height));
    }
    CGContextRestoreGState(ctx);
    
    // Dessine la checkbox
    CGContextSaveGState(ctx);
    {
        CGContextSetRGBStrokeColor(ctx, 1.0, 1.0, 1.0, 1.0);
        CGContextSetLineWidth(ctx, 5.0);
        CGContextMoveToPoint(ctx, 36.0, 27);
        CGContextAddLineToPoint(ctx, 22, 41.0);
        CGContextAddLineToPoint(ctx, 14.0, 33.0);
        CGContextSetShouldAntialias(ctx, YES);
        CGContextStrokePath(ctx);
    }
    CGContextRestoreGState(ctx);
    
    UIImage *selectedMark = UIGraphicsGetImageFromCurrentImageContext();    // Récupération de ce qui a été dessiné.
    
    // Fermeture du conteneur. L'image est terminée.
    UIGraphicsEndImageContext();
    
    return selectedMark;
}
@end
