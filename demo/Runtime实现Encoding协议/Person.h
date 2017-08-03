//
//  Person.h
//  Runtime实现Encoding协议
//
//  Created by Vincent on 21/7/15.
//  Copyright (c) 2015 VF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject <NSCoding>
@property (nonatomic, assign) int age;
@property (nonatomic, assign) BOOL married;
@property (nonatomic, copy) NSString *name;
@end
