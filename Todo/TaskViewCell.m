//
//  TaskViewCell.m
//  Todo
//
//  Created by Christophe Massolin on 27/01/13.
//  Copyright (c) 2013 FuriouZz. All rights reserved.
//

#import "TaskViewCell.h"
#import "Task.h"

@implementation TaskViewCell
@synthesize task = _task;

- (void)dealloc {
    [_task release];
    [super dealloc];
}

// Définition du style de la cellule à l'initialisation de l'object
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Style du titre
        self.textLabel.adjustsFontSizeToFitWidth = YES;
        self.textLabel.textColor = [UIColor darkGrayColor];             // Couleur pour le titre
        
        // Style du détail
        self.detailTextLabel.font = [UIFont systemFontOfSize:12.0f];    // Taille du texte de la description
        self.detailTextLabel.numberOfLines = 0;                         // Nombre de ligne à afficher
        
        // Style de la cellule
        self.selectionStyle = UITableViewCellSelectionStyleGray;        // Style de la cellule à la selection
    }
    
    return self;
}

- (void)setTask:(Task *)task {
    _task = task;
    
    self.textLabel.text = _task.title;
    self.detailTextLabel.text = _task.description;
    
//    [self setNeedsLayout];
}

+ (CGFloat)heightForCellWithPost:(Task *)task {
    CGSize sizeToFit = [task.description sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(220.0f, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    
    return fmaxf(70.0f, sizeToFit.height + 45.0f);
}

//#pragma mark - UIView
//
//- (void)layoutSubviews {
//    [super layoutSubviews];
//    
//    //self.imageView.frame = CGRectMake(10.0f, 10.0f, 50.0f, 50.0f);
//    self.textLabel.frame = CGRectMake(70.0f, 10.0f, 240.0f, 20.0f);
//    
//    CGRect detailTextLabelFrame = CGRectOffset(self.textLabel.frame, 0.0f, 25.0f);
//    detailTextLabelFrame.size.height = [[self class] heightForCellWithPost:_task] - 45.0f;
//    self.detailTextLabel.frame = detailTextLabelFrame;
//}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated
//{
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}
@end
