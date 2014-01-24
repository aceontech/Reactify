//
//  Proxy.h
//  RuntimeTest
//
//  Created by Alex Manarpies on 24/01/14.
//  Copyright (c) 2014 Ace on Tech. All rights reserved.
//

@class RACSignal;

@interface Proxy : NSObject

- (RACSignal *)signalForSelector:(SEL)selector;

@end
