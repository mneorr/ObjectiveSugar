//
//  NSObject+Additions.h
//  TenzingCore
//
//  Created by Endika Gutiérrez Salas on 10/16/12.
//  Copyright (c) 2012 Tenzing. All rights reserved.
//

#import <Foundation/Foundation.h>

#define $(sel)  (@selector(sel))
#define $_(sel) ([NSValue valueWithPointer:(@selector(sel))])

@interface NSObject (Additions)

- (id)initWithValuesInDictionary:(NSDictionary *)dict;

- (NSDictionary *)asDictionary;

- (id)trySelector:(SEL)selector;
- (id)trySelector:(SEL)selector withObject:(id)obj;
- (id)trySelector:(SEL)selector withObject:(id)obj0 withObject:(id)obj1;

+ (void)defineMethod:(SEL)selector do:(id(^)(id _self, ...))implementation;
+ (void)defineClassMethod:(SEL)selector do:(id(^)(id _self, ...))implementation;

+ (Class)subclass:(NSString *)className;

/**
 Inspects all instance methods for calling class
 
 @return an array of strings containing all instance methods for calling class
 
 */
+ (NSArray *)instanceMethods;

/**
 * Inspects all instance methods for calling class
 *
 * @return an array of strings containing all instance methods for calling class
 */
+ (NSArray *)classMethods;

/**
 * Inspects all class methods for calling class
 *
 * @return an array of strings containing all class methods for calling class
 */
+ (NSArray *)instanceProperties;

/**
 * Inspects class of a given property. Checks class of property NOT class of object at property.
 *
 * @return class of property or nil if class does not has property or if it is not object
 */
+ (Class)classForProperty:(NSString *)propertyName;

/**
 * Inspects type of a given property and returns it's code. 
 * See https://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html
 * 
 * @return char with type encoding
 */
+ (char)typeForProperty:(NSString *)propertyName;

/**
 * Checks if object has property
 *
 * @return true if object has property with name
 */
+ (BOOL)hasProperty:(NSString *)propertyName;

@end
