//
//  Task.h
//  Todo
//
//  Created by Christophe Massolin on 27/01/13.
//  Copyright (c) 2013 FuriouZz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Task : NSObject

@property (assign, nonatomic) NSUInteger taskID;
@property (retain, nonatomic) NSString *title;
@property (retain, nonatomic) NSString *description;

- (id)initWithAttributes:(NSDictionary *)attributes;
+ (NSArray *)loadTasks;
@end
