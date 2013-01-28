//
//  Task.h
//  Todo
//
//  Created by Christophe Massolin on 27/01/13.
//  Copyright (c) 2013 FuriouZz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Task : NSObject

@property (readonly) NSUInteger taskID;
@property (readonly) NSString *title;
@property (readonly) NSString *description;

- (id)initWithAttributes:(NSDictionary *)attributes;

//+ (NSArray *)loadTask;

@end
