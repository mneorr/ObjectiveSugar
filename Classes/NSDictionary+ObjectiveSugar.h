//
//  NSDictionary+ObjectiveSugar.h
//  SampleProject
//
//  Created by Marin Usalj on 11/23/12.
//  Copyright (c) 2012 @supermarin | supermar.in. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary<__covariant KeyType, __covariant ObjectType> (ObjectiveSugar)

- (void)each:(void (^)(KeyType key, ObjectType value))block;
- (void)eachKey:(void (^)(KeyType key))block;
- (void)eachValue:(void (^)(ObjectType value))block;
- (NSArray *)map:(id __nullable (^)(KeyType key, ObjectType value))block;
- (BOOL)hasKey:(KeyType)key;
- (NSDictionary<KeyType, ObjectType> *)pick:(NSArray<KeyType> *)keys;
- (NSDictionary<KeyType, ObjectType> *)omit:(NSArray<KeyType> *)keys;
- (NSDictionary<KeyType, ObjectType> *)merge:(NSDictionary<KeyType, ObjectType> *)dictionary;
- (NSDictionary *)merge:(NSDictionary *)dictionary block:(id __nullable (^)(id key, ObjectType oldVal, id newVal))block;
- (NSDictionary<ObjectType, KeyType> *)invert;

@end

NS_ASSUME_NONNULL_END
