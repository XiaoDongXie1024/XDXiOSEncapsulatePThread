//
//  XDXPThreadHandler.h
//  XDXiOSEncapsulatePThread
//
//  Created by 小东邪 on 2018/11/27.
//  Copyright © 2018 小东邪. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XDXPThreadHandler : NSObject

@property (nonatomic, copy  ) NSString *baseThreadName;
- (void)setBaseThreadName:(NSString *)name;

- (void)doBaseThreadTask;

- (BOOL)isStopBaseThread;
- (BOOL)isPauseBaseThread;

- (void)startBaseThreadTask;
- (void)stopBaseThreadTaskThread;

- (void)pauseBaseThread;
- (void)continueBaseThread;

@end

NS_ASSUME_NONNULL_END
