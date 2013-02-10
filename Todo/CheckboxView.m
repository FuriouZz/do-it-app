//
//  CheckboxView.m
//  Todo
//
//  Created by Christophe Massolin on 10/02/13.
//  Copyright (c) 2013 FuriouZz. All rights reserved.
//

#import "CheckboxView.h"

#define checkboxSize        CGSizeMake(50.0, 69.0)
#define checkboxMargin      10
#define checkboxBoxWidth    checkboxSize.width + checkboxMargin

@implementation CheckboxView
@synthesize indexPath = _indexPath;

- (void)dealloc
{
    [_indexPath release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
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

#pragma mark - Events
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.delegate changeMarkStateAtIndexPath:_indexPath];
}

@end
