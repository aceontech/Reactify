//
//  Proxy.m
//  RuntimeTest
//
//  Created by Alex Manarpies on 24/01/14.
//  Copyright (c) 2014 Ace on Tech. All rights reserved.
//

#import "Proxy.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import <ReactiveCocoa.h>

#import "DynamicDelegateNextObject.h"

@interface Proxy()
@property (nonatomic,strong) NSMutableDictionary *signalMap;
@end

@implementation Proxy

- (void)forwardInvocation:(NSInvocation *)invocation
{
    NSString *selectorString = NSStringFromSelector(invocation.selector);
    RACSubject *signal = self.signalMap[selectorString];
    
    NSMethodSignature *signature = [invocation methodSignature];
    NSMutableArray *arguments = [[NSMutableArray alloc] init];
    if ([signature numberOfArguments] > 2)
    {
        for (NSInteger i = 2; i < [signature numberOfArguments]; i++)
        {
            id argument;
            [invocation getArgument:&argument atIndex:i];
            
            [arguments addObject:argument];
        }
    }
    
    DynamicDelegateNextObject *next;
    
    NSInteger argumentsCount = [arguments count];
    BOOL hasReturnType = strcmp([signature methodReturnType], @encode(void)) != 0;
    
    if (argumentsCount || hasReturnType) {
        next = [[DynamicDelegateNextObject alloc] init];
    }
    
    if (argumentsCount) {
        next.arguments = arguments;
    }
    
    if (hasReturnType) {
        next.returnBlock = ^(void *returnObject) {
            [invocation setReturnValue:returnObject];
        };
    }
    
    [signal sendNext:next];
}

- (IMP)methodForSelector:(SEL)aSelector
{
    return NULL; //imp_implementationWithBlock(^(){ return @"SHIT YO"; });
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
