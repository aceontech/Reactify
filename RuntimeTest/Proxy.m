//
//  Proxy.m
//  RuntimeTest
//
//  Created by Alex Manarpies on 24/01/14.
//  Copyright (c) 2014 Ace on Tech. All rights reserved.
//

#import "Proxy.h"
#import <objc/runtime.h>
#import <ReactiveCocoa.h>

@interface Proxy()
@property (nonatomic,strong) NSMutableDictionary *signalMap;
@end

@implementation Proxy

- (void)forwardInvocation:(NSInvocation *)invocation
{
    NSString *selectorString = NSStringFromSelector(invocation.selector);
    RACSubject *signal = self.signalMap[selectorString];
    
    // TODO: Get arguments from [invocation methodSignature];
    [signal sendNext:nil];
}

- (IMP)methodForSelector:(SEL)aSelector
{
    return imp_implementationWithBlock(^(){ return @"SHIT YO"; });
}

- (NSMutableDictionary *)signalMap
{
    if (!_signalMap) {
        _signalMap = [[NSMutableDictionary alloc] init];
    }
    return _signalMap;
}

- (RACSignal *)signalForSelector:(SEL)selector
{
    NSString *selectorString = NSStringFromSelector(selector);
    
    if (!self.signalMap[selectorString]) {
        self.signalMap[selectorString] = [RACSubject subject];
    }
    
    return self.signalMap[selectorString];
}

@end
