//
//  main.m
//  Runtime实现Encoding协议
//
//  Created by Vincent on 21/7/15.
//  Copyright (c) 2015 VF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSMutableArray *arr = [NSMutableArray array];
        for (int i = 0; i < 5; i ++) {
            Person *person1 = [[Person alloc] init];
            person1.isMarried = YES;
            person1.age = 23 + i;
            person1.name = @"张xx";
            [person1 setValue:[NSDate date] forKey:@"_marriedDate"];
            [arr addObject:person1];
        }
        // 数组也可以直接读写。
        [NSKeyedArchiver archiveRootObject:arr toFile:@"/Users/Vincent/Desktop/a.archiver"];
        
        sleep(2);
        id p = [NSKeyedUnarchiver unarchiveObjectWithFile:@"/Users/Vincent/Desktop/a.archiver"];
        if ([p isKindOfClass:[NSArray class]]) {
            for (id obj in p) {
                NSLog(@"%@", obj);
            }
        }
    }
    return 0;
}
