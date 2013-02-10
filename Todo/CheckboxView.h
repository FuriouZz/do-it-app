//
//  CheckboxView.h
//  Todo
//
//  Created by Christophe Massolin on 10/02/13.
//  Copyright (c) 2013 FuriouZz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TodoViewCell;

@protocol CheckboxViewDelegate
- (void) changeMarkStateAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface CheckboxView : UIImageView
@property (nonatomic, assign) id <CheckboxViewDelegate> delegate;
@property (nonatomic, retain) NSIndexPath *indexPath;

- (UIImage *)renderMark;
@end
