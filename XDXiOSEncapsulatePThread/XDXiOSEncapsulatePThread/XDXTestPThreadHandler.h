//
//  XDXTestPThreadHandler.h
//  XDXiOSEncapsulatePThread
//
//  Created by 小东邪 on 2018/12/3.
//  Copyright © 2018 小东邪. All rights reserved.
//

#import "XDXPThreadHandler.h"

NS_ASSUME_NONNULL_BEGIN

@interface XDXTestPThreadHandler : XDXPThreadHandler
- (void)setBaseThreadName:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
