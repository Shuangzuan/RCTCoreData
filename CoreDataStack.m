//
//  CoreDataStack.m
//  RCTCoreData
//
//  Created by Seven on 6/4/15.
//  Copyright (c) 2015 Facebook. All rights reserved.
//

#import "CoreDataStack.h"

@import CoreData;

@interface CoreDataStack ()

@end

@implementation CoreDataStack

#pragma mark - Public APIs

+ (instancetype)sharedInstance {
  static CoreDataStack *stack = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    stack = [[CoreDataStack alloc] init];
  });
  return stack;
}

- (void)setupWithModelFileName:(NSString *)modelFileName {
  if (self.modelFileName) return;
  
  self.modelFileName = modelFileName;
  
  [self store];
}

- (void)saveContext {
  NSError *error;

  if (self.context.hasChanges && ![self.context save:&error]) {
    NSLog(@"Could not save: %@, %@", error, error.userInfo);
  }
}

#pragma mark - Properties

- (NSManagedObjectContext *)context {
  if (!_context) {
    _context = [[NSManagedObjectContext alloc] init];
    _context.persistentStoreCoordinator = self.coordinator;
  }
  return _context;
}

- (NSPersistentStoreCoordinator *)coordinator {
  if (!_coordinator) {
    _coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.model];
  }
  return _coordinator;
}

- (NSManagedObjectModel *)model {
  if (!_model) {
    NSBundle *bundle = [NSBundle mainBundle];
    NSURL *modelURL = [bundle URLForResource:self.modelFileName withExtension:@"momd"];
    _model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
  }
  return _model;
}

- (NSPersistentStore *)store {
  if (!_store) {
    NSURL *documentsURL = [self applicationDocumentsDirectory];
    NSURL *storeURL = [documentsURL URLByAppendingPathComponent:self.modelFileName];
    NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption: @(YES)};
    
    NSError *error;
    _store = [self.coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error];
    
    if (!_store) {
      NSLog(@"Error adding persistent store: %@", error);
      abort();
    }
  }
  return _store;
}

#pragma mark - Helpers

- (NSURL *)applicationDocumentsDirectory {
  NSFileManager *manager = [NSFileManager defaultManager];
  return [[manager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
}

@end
