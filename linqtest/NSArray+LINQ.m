//
//  NSArray+LINQ.m
//  linqtest
//
//  Created by Matt Bridges on 11/10/12.
//  Copyright (c) 2012 Matt Bridges. All rights reserved.
//

#import "NSArray+LINQ.h"

@implementation NSArray (LINQ)

- (SelectPropertyType) Select
{
    SelectPropertyType t = ^(SelectLambda f) {
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:[self count]];
        
        for (id obj in self) {
            [arr addObject:f(obj)];
        }
        
        return arr;
    };
    
    return t;
}

- (WherePropertyType) Where
{
    WherePropertyType t = ^(BoolLambda f) {
        NSMutableArray *arr = [NSMutableArray array];
        
        for (id obj in self) {
            if (f(obj)) {
                [arr addObject:obj];
            }
        }
        
        return arr;
    };
    
    return t;
}

- (AnyPropertyType) Any
{
    AnyPropertyType t = ^{
        if ([self count] > 0) {
            return YES;
        } else {
            return NO;
        }
    };
    
    return t;
}

- (AnyWithBlockPropertyType) AnyWithBlock
{
    AnyWithBlockPropertyType t = ^(BoolLambda f) {
        for (id obj in self) {
            if (f(obj)) {
                return YES;
            }
        }
        
        return NO;
    };
    
    return t;
}

- (FirstPropertyType) First
{
    FirstPropertyType t = ^{
        if ([self count] > 0) {
            return [self objectAtIndex:0];
        } else {
            return (id)nil;
        }
    };
    
    return t;
}

- (FirstWithBlockPropertyType) FirstWithBlock
{
    FirstWithBlockPropertyType t = ^(BoolLambda f) {
        for (id obj in self) {
            if (f(obj)) {
                return obj;
            }
        }
        
        return (id)nil;
    };
    
    return t;
}

- (AllPropertyType) All
{
    AllPropertyType t = ^(BoolLambda f) {
        for (id obj in self) {
            if (!f(obj)) {
                return NO;
            }
        }
        
        return YES;
    };
    
    return t;
}

- (DistinctPropertyType) Distinct
{
    DistinctPropertyType t = ^{
        NSSet *set = [NSSet setWithArray:self];
        return [set allObjects];
    };
    
    return t;
}


@end