//
//  TaskViewCell.m
//  Todo
//
//  Created by Christophe Massolin on 27/01/13.
//  Copyright (c) 2013 FuriouZz. All rights reserved.
//

#import "TodoViewCell.h"
#import "Todo.h"

@implementation TodoViewCell
@synthesize task = _task;
@synthesize textLabel = _label;
@synthesize detailTextLabel = _detailLabel;
@synthesize checkbox = _checkbox;

- (void)dealloc {
    [_checkbox release];
    [_task release];
    [super dealloc];
}

// Définition du style de la cellule à l'initialisation de l'object
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(65, 10, self.frame.size.width-65, 30)];
        [self.contentView addSubview:_label];
        
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 35, self.frame.size.width-65, 20)];
        [self.contentView addSubview:_detailLabel];
        
        // Style du titre
        self.textLabel.adjustsFontSizeToFitWidth = YES;
        self.textLabel.textColor = [UIColor darkGrayColor];             // Couleur pour le titre
        
        // Style du détail
        self.detailTextLabel.font = [UIFont systemFontOfSize:12.0f];    // Taille du texte de la description
        self.detailTextLabel.numberOfLines = 0;                         // Nombre de ligne à afficher
        
        // Style de la cellule
        self.selectionStyle = UITableViewCellSelectionStyleGray;        // Style de la cellule à la selection
        
        //self.bounds = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, 290, self.bounds.size.height);
        //[self addSubview:_checkbox];
    }
    
    return self;
}

-(void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetRGBFillColor(ctx, .8, .5, .6, 1);
    //CGContextSetRGBStrokeColor(ctx, .8, .5, .6, 1);
    CGContextFillRect(ctx, CGRectMake(0, 0, 50, self.frame.size.height));
    //CGContextStrokeRect(ctx, CGRectMake(0, 0, 50, self.frame.size.height));
    
    [super drawRect:rect];
    

}

- (void)setTask:(Todo *)task {
    _task = task;

    self.textLabel.text = _task.title;
    self.detailTextLabel.text = _task.note;
}

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
@end
