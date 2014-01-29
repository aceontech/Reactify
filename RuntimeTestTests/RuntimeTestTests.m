//
//  RuntimeTestTests.m
//  RuntimeTestTests
//
//  Created by Alex Manarpies on 24/01/14.
//  Copyright (c) 2014 Ace on Tech. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <objc/runtime.h>
#import "ProtocolA.h"
#import "Proxy.h"
#import "ObjectA.h"
#import <ReactiveCocoa.h>
#import "DynamicDelegateNextObject.h"

@interface RuntimeTestTests : XCTestCase
@end

@implementation RuntimeTestTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testExample
{
    Class DynamicDelegate = objc_allocateClassPair([Proxy class], "DelegatingClass", 0);
    class_addProtocol(DynamicDelegate, @protocol(ProtocolA));
    
    id<ProtocolA> dynamicDelegateInstance = [[DynamicDelegate alloc] init];
    ObjectA *objA = [[ObjectA alloc] init];
    objA.delegate = dynamicDelegateInstance;
    
    [[(Proxy *)dynamicDelegateInstance signalForSelector:@selector(firstMethod)] subscribeNext:^(id x) {
        NSLog(@"NEXT");
    }];
    
    [[(Proxy *)dynamicDelegateInstance signalForSelector:@selector(secondMethod:)] subscribeNext:^(DynamicDelegateNextObject *x) {
        NSLog(@"NEXT %@", x.arguments);
        NSString *str = @"meh";
        x.returnBlock(&str);
    }];
    
    [[(Proxy *)dynamicDelegateInstance signalForSelector:@selector(thirdMethod)] subscribeNext:^(DynamicDelegateNextObject *x) {
        NSLog(@"NEXT");
        BOOL yes = YES;
        x.returnBlock(&yes);
    }];
    
    [[(Proxy *)dynamicDelegateInstance signalForSelector:@selector(fourthMethod)] subscribeNext:^(DynamicDelegateNextObject *x) {
        NSLog(@"NEXT");
        NSString *str = @"test!";
        x.returnBlock(&str);
    }];
    
    [objA startCallingDelegate];
    
    XCTAssertTrue([dynamicDelegateInstance conformsToProtocol:@protocol(ProtocolA)], @"Object doesn't conform to protocol");
}

@end
