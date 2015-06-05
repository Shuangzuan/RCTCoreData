//
//  CoreDataStack.h
//  RCTCoreData
//
//  Created by Seven on 6/4/15.
//  Copyright (c) 2015 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSManagedObjectContext, NSPersistentStoreCoordinator, NSManagedObjectModel, NSPersistentStore;

@interface CoreDataStack : NSObject

@property (strong, nonatomic) NSString *modelFileName;

@property (strong, nonatomic) NSManagedObjectContext *context;
@property (strong, nonatomic) NSPersistentStoreCoordinator *coordinator;
@property (strong, nonatomic) NSManagedObjectModel *model;
@property (strong, nonatomic) NSPersistentStore *store;

+ (instancetype)sharedInstance;

- (void)setupWithModelFileName:(NSString *)modelFileName;

- (void)saveContext;

@end
