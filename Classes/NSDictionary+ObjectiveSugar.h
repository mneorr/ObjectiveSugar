//
//  NSDictionary+ObjectiveSugar.h
//  SampleProject
//
//  Created by Marin Usalj on 11/23/12.
//  Copyright (c) 2012 @mneorr | mneorr.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (ObjectiveSugar)


/**
 * Iterate through all items in the dictionary passing
 * the key and value into a block
 **/

- (void)each:(void (^)(id key, id value))block;

/**
 * Iterate though all the keys in the dictionary
 **/

- (void)eachKey:(void (^)(id key))block;

/**
 * Iterate though all the valuse in the dictionary
 **/

- (void)eachValue:(void (^)(id value))block;

/**
 * Iterate though all the items in the dictionary
 * returning an array of objects returned from the
 * iteration block.
 **/

- (NSArray *)map:(id (^)(id key, id value))block;
- (BOOL)hasKey:(id)key;

@end
