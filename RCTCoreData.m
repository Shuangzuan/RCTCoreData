#import "RCTCoreData.h"
#import <RCTConvert.h>

#import "CoreDataStack.h"
#import "RCTConvert+ManagedObject.h"

@import CoreData;

@implementation RCTCoreData

- (void)loadWithModelFileName:(NSString *)modelFileName {
  CoreDataStack *stack = [CoreDataStack sharedInstance];
  [stack setupWithModelFileName:modelFileName];
}

- (void)tryLoadWithOptions:(NSDictionary *)options {
  NSString *modelFileName = options[@"modelFileName"];
  [self loadWithModelFileName:modelFileName];
}

#pragma mark -

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(add:(NSDictionary *)options callback:(RCTResponseSenderBlock)callback) {
  [self tryLoadWithOptions:options];
  
  NSString *entityName = options[@"entityName"];
  NSDictionary *properties = options[@"properties"];
  BOOL saveContext = [options[@"saveContext"] boolValue];
  
  CoreDataStack *stack = [CoreDataStack sharedInstance];
  
  NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:stack.context];
  NSManagedObject *object = [[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:stack.context];
  
  [properties enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
    // TODO: if obj is a managed object
    [object setValue:obj forKey:key];
  }];
  
  if (saveContext) [stack saveContext];
  
  callback(@[[NSNull null]]);
}

RCT_EXPORT_METHOD(fetch:(NSDictionary *)options callback:(RCTResponseSenderBlock)callback) {
  [self tryLoadWithOptions:options];
  
  NSString *entityName = options[@"entityName"];
  
  CoreDataStack *stack = [CoreDataStack sharedInstance];
  
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
  NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:stack.context];
  [fetchRequest setEntity:entity];
  
  // Specify criteria for filtering which objects to fetch
  // NSPredicate *predicate = [NSPredicate predicateWithFormat:@"<#format string#>", <#arguments#>];
  // [fetchRequest setPredicate:predicate];
  
  // Specify how the fetched objects should be sorted
  // NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"<#key#>" ascending:YES];
  // [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
  
  NSError *error;
  NSArray *fetchedObjects = [stack.context executeFetchRequest:fetchRequest error:&error];
  if (fetchedObjects) {
    NSLog(@"%@", fetchedObjects);
    NSLog(@"%@", [fetchedObjects.lastObject valueForKey:@"name"]);
  } else {
    NSLog(@"%@", error);
  }
}

RCT_EXPORT_METHOD(saveContext:(RCTResponseSenderBlock)callback) {
  CoreDataStack *stack = [CoreDataStack sharedInstance];
  [stack saveContext];
}

@end
