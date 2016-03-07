//
//  NSArray+ObjectiveSugar.h
//  Objective Sugar
//
//  Created by Marin Usalj on 5/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

// For an overview see http://cocoadocs.org/docsets/ObjectiveSugar/

#import <Foundation/Foundation.h>
#import "CompatibilityMacros.h"

NS_ASSUME_NONNULL_BEGIN

@interface __OBJECTIVE_SUGAR_GENERICS(NSArray, __covariant ObjectType) (ObjectiveSugar)

/**
 The first item in the array, or nil.

 @return  The first item in the array, or nil.
 */
- (nullable __OBJECTIVE_SUGAR_GENERICS_TYPE(ObjectType))first DEPRECATED_MSG_ATTRIBUTE("Please use -firstObject instead");

/**
 The last item in the array, or nil.

 @return  The last item in the array, or nil.
 */
- (nullable __OBJECTIVE_SUGAR_GENERICS_TYPE(ObjectType))last DEPRECATED_MSG_ATTRIBUTE("Please use -lastObject instead");

/**
 A random element in the array, or nil.

 @return  A random element in the array, or nil.
 */
- (nullable __OBJECTIVE_SUGAR_GENERICS_TYPE(ObjectType))sample;

/// Alias for -sample
- (nullable __OBJECTIVE_SUGAR_GENERICS_TYPE(ObjectType))anyObject;


/**
 Allow subscripting to fetch elements within the specified range

 @param key An NSString or NSValue wrapping an NSRange. It's intended to behave like Ruby's array range accessors.

        Given array of 10 elements, e.g. [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], you can perform these operations:
        array[@"1..3"] will give you [2, 3, 4]
        array[@"1...3"] will give you [2, 3] (last value excluded)
        array[@"1,3"] implies NSRange(location: 1, length: 3), and gives you [2, 3, 4]


 @return An array with elements within the specified range
 */
- (__OBJECTIVE_SUGAR_GENERICS(NSArray, ObjectType) *)objectForKeyedSubscript:(id <NSCopying>)key;


/**
 A simpler alias for `enumerateObjectsUsingBlock`

 @param block A block with the object in its arguments.
 */
- (void)each:(void (^)(__OBJECTIVE_SUGAR_GENERICS_TYPE(ObjectType) object))block;

/**
 A simpler alias for `enumerateObjectsUsingBlock` which also passes in an index

 @param block A block with the object in its arguments.
 */
- (void)eachWithIndex:(void (^)(__OBJECTIVE_SUGAR_GENERICS_TYPE(ObjectType) object, NSUInteger index))block;

/**
 A simpler alias for `enumerateObjectsWithOptions:usingBlock:`

 @param block A block with the object in its arguments.
 @param options Enumerating options.
 */

- (void)each:(void (^)(__OBJECTIVE_SUGAR_GENERICS_TYPE(ObjectType) object))block options:(NSEnumerationOptions)options;

/**
 A simpler alias for `enumerateObjectsWithOptions:usingBlock:` which also passes in an index

 @param block A block with the object in its arguments.
 @param options Enumerating options.
 */

- (void)eachWithIndex:(void (^)(__OBJECTIVE_SUGAR_GENERICS_TYPE(ObjectType) object, NSUInteger index))block options:(NSEnumerationOptions)options;


/**
 An alias for `containsObject`

 @param object An object that the array may or may not contain.
 */
- (BOOL)includes:(__OBJECTIVE_SUGAR_GENERICS_TYPE(ObjectType))object;

/**
 Take the first `numberOfElements` out of the array, or the maximum amount of
 elements if it is less.

 @param numberOfElements Number of elements to take from array
 @return An array of elements
 */
- (__OBJECTIVE_SUGAR_GENERICS(NSArray, ObjectType) *)take:(NSUInteger)numberOfElements;

/**
 Passes elements to the `block` until the block returns NO,
 then stops iterating and returns an array of all prior elements.

 @param block A block that returns YES/NO
 @return An array of elements
 */
- (__OBJECTIVE_SUGAR_GENERICS(NSArray, ObjectType) *)takeWhile:(BOOL (^)(__OBJECTIVE_SUGAR_GENERICS_TYPE(ObjectType) object))block;

/**
 Iterate through the current array running the block on each object and
 returning an array of the changed objects.

 @param block A block that passes in each object and returns a modified object
 @return An array of modified elements
 */
- (NSArray *)map:(id(^)(__OBJECTIVE_SUGAR_GENERICS_TYPE(ObjectType) object))block;

/**
 Iterate through current array asking whether to keep each element.

 @param block A block that returns YES/NO for whether the object should stay
 @return An array of elements selected
 */
- (__OBJECTIVE_SUGAR_GENERICS(NSArray, ObjectType) *)select:(BOOL (^)(__OBJECTIVE_SUGAR_GENERICS_TYPE(ObjectType) object))block;

/**
 Iterate through current array returning the first element meeting a criteria.

 @param block A block that returns YES/NO
 @return The first matching element
 */
- (nullable __OBJECTIVE_SUGAR_GENERICS_TYPE(ObjectType))detect:(BOOL (^)(__OBJECTIVE_SUGAR_GENERICS_TYPE(ObjectType) object))block;


/**
 Alias for `detect`. Iterate through current array returning the first element
 meeting a criteria.

 @param block A block that returns YES/NO
 @return The first matching element
 */
- (nullable __OBJECTIVE_SUGAR_GENERICS_TYPE(ObjectType))find:(BOOL (^)(__OBJECTIVE_SUGAR_GENERICS_TYPE(ObjectType) object))block;

/**
 Iterate through current array asking whether to remove each element.

 @param block A block that returns YES/NO for whether the object should be removed
 @return An array of elements not rejected
 */
- (__OBJECTIVE_SUGAR_GENERICS(NSArray, ObjectType) *)reject:(BOOL (^)(__OBJECTIVE_SUGAR_GENERICS_TYPE(ObjectType) object))block;

/**
 Recurse through self checking for NSArrays and extract all elements into one single array

 @return An array of all held arrays merged
 */
- (NSArray *)flatten;

/**
 Remove all the nulls from array

 @return A copy of the given array without NSNulls
 */
- (NSArray *)compact;

/**
 Alias for `componentsJoinedByString` with a default of no seperator

 @return A string of all objects joined with an empty string
 */
- (NSString *)join;

/**
 Alias for `componentsJoinedByString`

 @return A string of all objects joined with the `seperator` string
 */
- (NSString *)join:(NSString *)separator;

/**
 Run the default comparator on each object in the array

 @return A sorted copy of the array
 */
- (__OBJECTIVE_SUGAR_GENERICS(NSArray, ObjectType) *)sort;

/**
 Sorts the array using the the default comparator on the given key

 @return A sorted copy of the array
 */
- (__OBJECTIVE_SUGAR_GENERICS(NSArray, ObjectType) *)sortBy:(NSString *)key;

/**
 Alias for reverseObjectEnumerator.allObjects

 Returns a reversed array
 */
- (__OBJECTIVE_SUGAR_GENERICS(NSArray, ObjectType) *)reverse;

/**
 Return all the objects that are in both self and `array`.
 Alias for Ruby's & operator

 @return An array of objects common to both arrays
 */
- (__OBJECTIVE_SUGAR_GENERICS(NSArray, ObjectType) *)intersectionWithArray:(__OBJECTIVE_SUGAR_GENERICS(NSArray, ObjectType) *)array;

/**
 Return all the objects that in both self and `array` combined.
 Alias for Ruby's | operator

 @return An array of the two arrays combined
 */

- (__OBJECTIVE_SUGAR_GENERICS(NSArray, ObjectType) *)unionWithArray:(__OBJECTIVE_SUGAR_GENERICS(NSArray, ObjectType) *)array;

/**
 Return all the objects in self that are not in `array`.
 Alias for Ruby's - operator

 @return An array of the self without objects in `array`
 */

- (__OBJECTIVE_SUGAR_GENERICS(NSArray, ObjectType) *)relativeComplement:(__OBJECTIVE_SUGAR_GENERICS(NSArray, ObjectType) *)array;

/**
 Return all the objects that are unique to each array individually
 Alias for Ruby's ^ operator. Equivalent of a - b | b - a

 @return An array of elements which are in either of the arrays and not in their intersection.
 */
- (__OBJECTIVE_SUGAR_GENERICS(NSArray, ObjectType) *)symmetricDifference:(__OBJECTIVE_SUGAR_GENERICS(NSArray, ObjectType) *)array;

/**
 Return a single value from an array by iterating through the elements and transforming a running total.

 @return A single value that is the end result of apply the block function to each element successively.
 **/
- (nullable id)reduce:(id __nullable (^)(id __nullable accumulator, __OBJECTIVE_SUGAR_GENERICS_TYPE(ObjectType) object))block;

/**
 Same as -reduce, with initial value provided by yourself
 **/
- (nullable id)reduce:(nullable id)initial withBlock:(id __nullable (^)(id __nullable accumulator, __OBJECTIVE_SUGAR_GENERICS_TYPE(ObjectType) object))block;

/**
 Produces a duplicate-free version of the array
 
 @return a new array with all unique elements
 **/
- (__OBJECTIVE_SUGAR_GENERICS(NSArray, ObjectType) *)unique;

@end

NS_ASSUME_NONNULL_END