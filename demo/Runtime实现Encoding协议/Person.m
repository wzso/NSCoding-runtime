//
//  Person.m
//  Runtime实现Encoding协议
//
//  Created by Vincent on 21/7/15.
//  Copyright (c) 2015 VF. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>
#import <CoreData/CoreData.h>

@interface Person ()
{
    // 私有的也能通过KVC赋值 key==@"marriedDate"。有没有下划线都一样，都能被class_copyIvarList()获取
    NSDate *_marriedDate;
}
@end

@implementation Person
- (void)encodeWithCoder:(NSCoder *)aCoder {
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for ( int i = 0; i < count; i ++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
    
    free(ivars);
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([self class], &count);
        for (int i = 0; i < count; i ++) {
            Ivar ivar = ivars[i];
            const char *name = ivar_getName(ivar);
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [aDecoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
    }
    
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"This is %@, %d years old, %@.%@", self.name, self.age, (self.married ? @"married" : @"not married"), _marriedDate];
}
@end
