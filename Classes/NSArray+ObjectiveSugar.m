//
//  NSArray+ObjectiveSugar.m
//  WidgetPush
//
//  Created by Marin Usalj on 5/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSArray+ObjectiveSugar.h"
#import "NSMutableArray+ObjectiveSugar.h"
#import "NSString+ObjectiveSugar.h"

static NSString * const OSMinusString = @"-";

@implementation NSArray (ObjectiveSugar)

- (id)first {
    if (self.count > 0)
        return self[0];

    return nil;
}

- (id)last {
    return [self lastObject];
}

- (id)sample {
    if (self.count == 0) return nil;

    NSUInteger index = arc4random_uniform((u_int32_t)self.count);
    return self[index];
}

- (id)objectForKeyedSubscript:(id)key {
    if ([key isKindOfClass:[NSString class]])
        return [self subarrayWithRange:[self rangeFromString:key]];

    else if ([key isKindOfClass:[NSValue class]])
        return [self subarrayWithRange:[key rangeValue]];

    else
        [NSException raise:NSInvalidArgumentException format:@"expected NSString or NSValue argument, got %@ instead", [key class]];

    return nil;
}

- (NSRange)rangeFromString:(NSString *)string {
    NSRange range = NSRangeFromString(string);

    if ([string containsString:@"..."]) {
        range.length = isBackwardsRange(string) ? (self.count - 2) - range.length : range.length - range.location;

    } else if ([string containsString:@".."]) {
        range.length = isBackwardsRange(string) ? (self.count - 1) - range.length : range.length - range.location + 1;
    }

    return range;
}

- (void)each:(void (^)(id object))block {
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        block(obj);
    }];
}

- (void)eachWithIndex:(void (^)(id object, NSUInteger index))block {
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        block(obj, idx);
    }];
}

- (void)each:(void (^)(id object))block options:(NSEnumerationOptions)options {
    [self enumerateObjectsWithOptions:options usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        block(obj);
    }];
}

- (void)eachWithIndex:(void (^)(id object, NSUInteger index))block options:(NSEnumerationOptions)options {
    [self enumerateObjectsWithOptions:options usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        block(obj, idx);
    }];
}

- (BOOL)includes:(id)object {
    return [self containsObject:object];
}

- (NSArray *)take:(NSUInteger)numberOfElements {
    numberOfElements = MIN(numberOfElements, [self count]);
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:numberOfElements];

    for (NSUInteger i = 0; i < numberOfElements; i++) {
        [array addObject:self[i]];
    }

    return array;
}

- (NSArray *)takeWhile:(BOOL (^)(id object))block {
    NSMutableArray *array = [NSMutableArray array];

    for (id arrayObject in self) {
        if (block(arrayObject))
            [array addObject:arrayObject];

        else break;
    }

    return array;
}

- (NSArray *)map:(id (^)(id object))block {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];

    for (id object in self) {
        id newObject = block(object);
        if (newObject) {
          [array addObject:newObject];
        }
    }

    return array;
}

- (NSArray *)select:(BOOL (^)(id object))block {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];

    for (id object in self) {
        if (block(object)) {
            [array addObject:object];
        }
    }

    return array;
}

-(BOOL)all:(BOOL (^)(id))condition {
    
    for (id object in self) {
        if (!condition(object)) {
            return false;
        }
    }
    return true;
}
- (id)detect:(BOOL (^)(id object))block {

    for (id object in self) {
        if (block(object))
            return object;
    }

    return nil;
}

- (id)find:(BOOL (^)(id object))block {
    return [self detect:block];
}

- (NSArray *)reject:(BOOL (^)(id object))block {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];

    for (id object in self) {
        if (block(object) == NO) {
            [array addObject:object];
        }
    }

    return array;
}

- (NSArray *)flatten {
    NSMutableArray *array = [NSMutableArray array];

    for (id object in self) {
        if ([object isKindOfClass:NSArray.class]) {
            [array concat:[object flatten]];
        } else {
            [array addObject:object];
        }
    }

    return array;
}

- (NSString *)join {
    return [self componentsJoinedByString:@""];
}

- (NSString *)join:(NSString *)separator {
    return [self componentsJoinedByString:separator];
}

- (NSArray *)sort {
    return [self sortedArrayUsingSelector:@selector(compare:)];
}

- (NSArray *)sortBy:(NSString*)key; {
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:YES];
    return [self sortedArrayUsingDescriptors:@[descriptor]];
}

- (NSArray *)reverse {
    return self.reverseObjectEnumerator.allObjects;
}

#pragma mark - Set operations

- (NSArray *)intersectionWithArray:(NSArray *)array {
    NSPredicate *intersectPredicate = [NSPredicate predicateWithFormat:@"SELF IN %@", array];
    return [self filteredArrayUsingPredicate:intersectPredicate];
}

- (NSArray *)unionWithArray:(NSArray *)array {
    NSArray *complement = [self relativeComplement:array];
    return [complement arrayByAddingObjectsFromArray:array];
}

- (NSArray *)relativeComplement:(NSArray *)array {
    NSPredicate *relativeComplementPredicate = [NSPredicate predicateWithFormat:@"NOT SELF IN %@", array];
    return [self filteredArrayUsingPredicate:relativeComplementPredicate];
}

- (NSArray *)symmetricDifference:(NSArray *)array {
    NSArray *aSubtractB = [self relativeComplement:array];
    NSArray *bSubtractA = [array relativeComplement:self];
    return [aSubtractB unionWithArray:bSubtractA];
}

#pragma mark - Private

static inline BOOL isBackwardsRange(NSString *rangeString) {
    return [rangeString containsString:OSMinusString];
}

@end

