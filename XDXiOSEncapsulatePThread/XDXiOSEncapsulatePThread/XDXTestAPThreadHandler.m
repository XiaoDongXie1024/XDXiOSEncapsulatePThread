//
//  XDXTestAPThreadHandler.m
//  XDXiOSEncapsulatePThread
//
//  Created by 小东邪 on 2018/12/3.
//  Copyright © 2018 小东邪. All rights reserved.
//

#import "XDXTestAPThreadHandler.h"

@implementation XDXTestAPThreadHandler

static id _instace = nil;
- (id)init {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instace = [super init];
    });
    return _instace;
}

+ (instancetype)getInstance {
    return [[self alloc] init];
}

- (void)doBaseThreadTask {
    [super doBaseThreadTask];
    
    NSLog(@"World");
}


@end
