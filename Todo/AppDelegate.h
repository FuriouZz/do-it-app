//
//  AppDelegate.h
//  Todo
//
//  Created by Christophe Massolin on 27/01/13.
//  Copyright (c) 2013 FuriouZz. All rights reserved.
//
//
//  Core Data informations come from this page : http://developer.apple.com/library/ios/#documentation/DataManagement/Conceptual/iPhoneCoreData01/Articles/01_StartingOut.html#//apple_ref/doc/uid/TP40008305-CH105-SW1
//

#import <UIKit/UIKit.h>

//@interface AppDelegate : UIResponder <UIApplicationDelegate>
@interface AppDelegate : NSObject <UIApplicationDelegate>
@property (retain, nonatomic) UIWindow *window;
@property (retain, nonatomic) UINavigationController *navigationController;

// This properties provide access to what’s called the Core Data stack
@property (retain, nonatomic, readonly) NSManagedObjectModel *managedObjectModel;
@property (retain, nonatomic, readonly) NSManagedObjectContext *managedObjectContext;
@property (retain, nonatomic, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

//- (NSURL *)applicationDocumentsDirectory;       // returns the URL identifying the application’s documents directory, which is where the file containing the application’s data will be located
//- (void)saveContext;                            // Saves changes you make to model objects to the data file
@end
