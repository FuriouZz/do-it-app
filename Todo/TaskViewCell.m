//
//  TaskViewCell.m
//  Todo
//
//  Created by Christophe Massolin on 27/01/13.
//  Copyright (c) 2013 FuriouZz. All rights reserved.
//

#import "TaskViewCell.h"
#import "Task.h"

@implementation TaskViewCell {
    
@private
    __strong Task *_task;  // Variable privé
    
}

// Getter - Setter de Task
@synthesize task = _task;

// Définition du style de la cellule à l'initialisation de l'object
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    
    // Style du titre
    self.textLabel.adjustsFontSizeToFitWidth = YES;
    self.textLabel.textColor = [UIColor darkGrayColor];             // Couleur pour le titre

    // Style du détail
    self.detailTextLabel.font = [UIFont systemFontOfSize:12.0f];    // Taille du texte de la description
    self.detailTextLabel.numberOfLines = 2;                         // Nombre de ligne à afficher
    
    // Style de la cellule
    self.selectionStyle = UITableViewCellSelectionStyleGray;        // Style de la cellule à la selection
    
    return self;
}

- (void)setTask:(Task *)task
{
    _task = task;
    self.textLabel.text = _task.title;
    self.detailTextLabel.text = _task.description;
    
    [self setNeedsLayout];
}

+ (CGFloat)heightForCellWithPost:(Task *)task {
    CGSize sizeToFit = [task.description sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(220.0f, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];
    
    return fmaxf(70.0f, sizeToFit.height + 45.0f);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
