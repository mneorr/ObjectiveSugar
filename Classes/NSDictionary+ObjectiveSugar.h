//
//  NSDictionary+ObjectiveSugar.h
//  SampleProject
//
//  Created by Marin Usalj on 11/23/12.
//  Copyright (c) 2012 @supermarin | supermar.in. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CompatibilityMacros.h"

NS_ASSUME_NONNULL_BEGIN

@interface __OBJECTIVE_SUGAR_GENERICS(NSDictionary, __covariant KeyType, __covariant ObjectType) (ObjectiveSugar)

- (void)each:(void (^)(__OBJECTIVE_SUGAR_GENERICS_TYPE(KeyType) key, __OBJECTIVE_SUGAR_GENERICS_TYPE(ObjectType) value))block;
- (void)eachKey:(void (^)(__OBJECTIVE_SUGAR_GENERICS_TYPE(KeyType) key))block;
- (void)eachValue:(void (^)(__OBJECTIVE_SUGAR_GENERICS_TYPE(ObjectType) value))block;
- (NSArray *)map:(id __nullable (^)(__OBJECTIVE_SUGAR_GENERICS_TYPE(KeyType) key, __OBJECTIVE_SUGAR_GENERICS_TYPE(ObjectType) value))block;
- (BOOL)hasKey:(__OBJECTIVE_SUGAR_GENERICS_TYPE(KeyType))key;
- (NSDictionary *)pick:(NSArray __OBJECTIVE_SUGAR_GENERICS_PARAM(KeyType) *)keys;
- (NSDictionary *)omit:(NSArray __OBJECTIVE_SUGAR_GENERICS_PARAM(KeyType) *)keys;
- (NSDictionary *)merge:(NSDictionary *)dictionary;
- (NSDictionary *)merge:(NSDictionary *)dictionary block:(id __nullable (^)(id key, __OBJECTIVE_SUGAR_GENERICS_TYPE(ObjectType) oldVal, id newVal))block;
- (NSDictionary __OBJECTIVE_SUGAR_GENERICS_PARAM(ObjectType, KeyType) *)invert;

@end

NS_ASSUME_NONNULL_END
