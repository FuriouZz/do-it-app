//
//  Task.m
//  Todo
//
//  Created by Christophe Massolin on 27/01/13.
//  Copyright (c) 2013 FuriouZz. All rights reserved.
//

#import "Todo.h"

@implementation Todo
@synthesize taskID = _taskID;
@synthesize todo   = _todo;
@synthesize note   = _note;

- (void)dealloc {
    [_todo release];
    [_note release];
    [super dealloc];
}

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if(self){
        self.taskID = [[attributes objectForKey:@"id"] integerValue];
        self.todo   = [attributes objectForKey:@"todo"];
        self.note   = [attributes objectForKey:@"note"];
    }
    
    return self;
}

#pragma mark -

+ (NSArray *)loadTasks {
    // Création de mes tâches
    Todo *task1 = [self taskWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:@"3", @"id", @"Banane", @"todo", @"Description de la mort", @"note", nil]];
    Todo *task2 = [self taskWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:@"2", @"id", @"Banane 2", @"todo", @"Les bananes c'est bon, il faut en manger jour ET nuit.", @"note", nil]];
    
    return [NSArray arrayWithObjects:task1, task2, nil];
}

// Create a task
+ (Todo *)taskWithAttributes:(NSDictionary *)attributes {
    return [[[Todo alloc] initWithAttributes:attributes] autorelease];
}

@end
