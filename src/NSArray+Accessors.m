//
//  NSArray+Accessors.m
//  WidgetPush
//
//  Created by Marin Usalj on 5/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSArray+Accessors.h"

@implementation NSArray (Accessors)
@dynamic first, last;

- (id)first {
    return [self objectAtIndex:0];
}

- (id)last {
    return [self lastObject];
}

- (void)each:(void (^)(id object))block {
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        block(obj); 
    }];
}

- (void)eachWithIndex:(void (^)(id object, int index))block {
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        block(obj, idx); 
    }];
}

- (BOOL)includes:(id)object
{
    return [self containsObject:object];
}

- (NSArray *)take:(NSUInteger)numberOfElements
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:numberOfElements];
    
    for (NSUInteger i = 0; i < numberOfElements; i++) {
        [array addObject:self[i]];
    }
    
    return array;
}

- (NSArray *)takeWith:(BOOL (^)(id object))block
{
    NSMutableArray *array = [NSMutableArray array];
    
    for (id arrayObject in self) {
        if (block(arrayObject)) {
            [array addObject:arrayObject];
        } else {
            break;
        }
    }
    
    return array;
}

@end

@implementation NSMutableArray (Rubyfy)

- (void)push:(id)object
{
    [self addObject:object];
}

- (id)pop
{
    id object = [self lastObject];
    [self removeLastObject];
    
    return object;
}

- (NSArray *)pop:(NSUInteger)numberOfElements
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:numberOfElements];
    
    for (int i = 0; i < numberOfElements; i++) {
        [array insertObject:[self pop] atIndex:0];
    }
    
    return array;
}

@end
