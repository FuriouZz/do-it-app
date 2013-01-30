//
//  Task.m
//  Todo
//
//  Created by Christophe Massolin on 27/01/13.
//  Copyright (c) 2013 FuriouZz. All rights reserved.
//

#import "Task.h"

@implementation Task
@synthesize taskID      = _taskID;
@synthesize title       = _title;
@synthesize description = _description;

- (void)dealloc {
    [_title release];
    [_description release];
    [super dealloc];
}

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if(self){
        self.taskID      = [[attributes valueForKeyPath:@"id"] integerValue];
        self.title       = [attributes valueForKeyPath:@"title"];
        self.description = [attributes valueForKeyPath:@"description"];
    }
    
    return self;
}

#pragma mark -

+ (NSArray *)loadTasks {
    // Création de mes tâches
    Task *task1 = [self taskWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:@"Banane", @"title", @"Description de la mort", @"description", nil]];
    Task *task2 = [self taskWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:@"Banane 2", @"title", @"Les bananes c'est bon, il faut en manger jour ET nuit.", @"description", nil]];
    
    return [NSArray arrayWithObjects:task1, task2, nil];
}

// Create a task
+ (Task *)taskWithAttributes:(NSDictionary *)attributes {
    return [[[Task alloc] initWithAttributes:attributes] autorelease];
}

@end
