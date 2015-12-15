//
//  NSMutableArray+ObjectiveSugar.h
//  SampleProject
//
//  Created by Marin Usalj on 11/23/12.
//  Copyright (c) 2012 @supermarin | supermar.in. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CompatibilityMacros.h"

NS_ASSUME_NONNULL_BEGIN

@interface __OBJECTIVE_SUGAR_GENERICS(NSMutableArray, ObjectType) (ObjectiveSugar)

/// Alias for -addObject. Appends the given object at the end
- (void)push:(__OBJECTIVE_SUGAR_GENERICS_TYPE(ObjectType))object;

/**
 Removes the last item of the array, and returns that item
 Note: This method changes the length of the array!

 @return First array item or nil.
 */
- (nullable __OBJECTIVE_SUGAR_GENERICS_TYPE(ObjectType))pop;


/**
 Removes the last n items of the array, and returns that item
 Note: This method changes the length of the array!

 @return First array item or nil.
 */
- (__OBJECTIVE_SUGAR_GENERICS(NSArray, ObjectType) *)pop:(NSUInteger)numberOfElements;
- (void)concat:(__OBJECTIVE_SUGAR_GENERICS(NSArray, ObjectType) *)array;


/**
 Removes the first item of the array, and returns that item
 Note: This method changes the length of the array!

 @return First array item or nil.
 */
- (nullable __OBJECTIVE_SUGAR_GENERICS_TYPE(ObjectType))shift;


/**
 Removes N first items of the array, and returns that items
 Note: This method changes the length of the array!

 @return Array of first N items or empty array.
 */
- (__OBJECTIVE_SUGAR_GENERICS(NSArray, ObjectType) *)shift:(NSUInteger)numberOfElements;


/**
 Deletes every element of the array for which the given block evaluates to NO.

 @param block block that returns YES/NO
 @return An array of elements
 */
- (__OBJECTIVE_SUGAR_GENERICS(NSArray, ObjectType) *)keepIf:(BOOL (^)(__OBJECTIVE_SUGAR_GENERICS_TYPE(ObjectType) object))block;

@end

NS_ASSUME_NONNULL_END
