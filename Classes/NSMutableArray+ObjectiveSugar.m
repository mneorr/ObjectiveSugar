//
//  NSMutableArray+ObjectiveSugar.m
//  SampleProject
//
//  Created by Marin Usalj on 11/23/12.
//  Copyright (c) 2012 @supermarin | supermar.in. All rights reserved.
//

#import "NSArray+ObjectiveSugar.h"
#import "NSMutableArray+ObjectiveSugar.h"

@implementation NSMutableArray (ObjectiveSugar)

- (void)push:(id)object {
  [self addObject:object];
}

- (id)pop {
  id object = [self lastObject];
  [self removeLastObject];

  return object;
}

- (NSArray *)pop:(NSUInteger)numberOfElements {
  NSMutableArray *array = [NSMutableArray arrayWithCapacity:numberOfElements];

  for (NSUInteger i = 0; i < numberOfElements; i++)
    [array insertObject:[self pop] atIndex:0];

  return array;
}

- (void)concat:(NSArray *)array {
  [self addObjectsFromArray:array];
}

- (id)shift {
  NSArray *result = [self shift:1];
  return [result firstObject];
}

- (NSArray *)shift:(NSUInteger)numberOfElements {
  NSUInteger shiftLength = MIN(numberOfElements, [self count]);

  NSRange range = NSMakeRange(0, shiftLength);
  NSArray *result = [self subarrayWithRange:range];
  [self removeObjectsInRange:range];

  return result;
}

- (NSArray *)keepIf:(BOOL (^)(id object))block {
  [self filterUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(
                                              id evaluatedObject,
                                              NSDictionary *bindings) {
          return block(evaluatedObject);
        }]];
  return self;
}

- (void)sortArrayByKey:(NSString *)key ascending:(BOOL)ascending {
  [self sortArrayByKeys:@[ key ] ascending:@[ @(ascending) ]];
}

- (void)sortArrayByKeys:(NSArray *)keys ascending:(NSArray *)ascendingArray {
  NSMutableArray *sortDescriptors = [NSMutableArray array];
  for (NSInteger i = 0; i < keys.count && i < ascendingArray.count; i++) {
    NSString *key = keys[i];
    BOOL ascending = [ascendingArray[i] boolValue];
    NSSortDescriptor *descriptor =
        [NSSortDescriptor sortDescriptorWithKey:key ascending:ascending];
    [sortDescriptors addObject:descriptor];
  }
  [self sortUsingDescriptors:sortDescriptors];
}

@end
