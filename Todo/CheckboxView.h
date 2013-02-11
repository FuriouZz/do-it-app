//
//  CheckboxView.h
//  Todo
//
//  Created by FuriouZz on 11/02/13.
//  Copyright (c) 2013 FuriouZz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CheckboxViewDelegate
- (void) changeMarkStateOnTap:(id)anyObject;
@end

@interface CheckboxView : UIImageView
@property (nonatomic, assign) id <CheckboxViewDelegate> delegate;
- (UIImage *)renderMark;
@end
