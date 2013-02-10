//
//  Todo.h
//  Todo
//
//  Created by Christophe Massolin on 10/02/13.
//  Copyright (c) 2013 FuriouZz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Todo : NSManagedObject

@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSNumber * isChecked;
@property (nonatomic, retain) NSString * note;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * updatedAt;

@end
