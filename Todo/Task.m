//
//  Task.m
//  Todo
//
//  Created by Christophe Massolin on 27/01/13.
//  Copyright (c) 2013 FuriouZz. All rights reserved.
//

#import "Task.h"

@implementation Task

@synthesize taskId      = _taskId;
@synthesize title       = _title;
@synthesize description = _description;

- (id)initWithAttributes:(NSDictionary *)attributes
{
    [super init];
    if(!self){
        return nil;
    }
    
    _taskId      = [[attributes valueForKeyPath:@"id"] integerValue];
    _title       = [attributes valueForKeyPath:@"title"];
    _description = [attributes valueForKeyPath:@"description"];
    
    return self;
}

+ (NSArray *)loadTasks
{
    NSMutableArray *mutableTasks = [NSMutableArray array];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                          @"Banane", @"title", @"Description", @"description", nil];
    
    Task *task = [[Task alloc] initWithAttributes:dict];

    [mutableTasks addObject:task];
    
    return mutableTasks;
}

@end
