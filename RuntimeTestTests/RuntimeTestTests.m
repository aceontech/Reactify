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
//    Class ProtocolAAdoptingClass = objc_allocateClassPair([NSObject class], "ProtocolAAdoptingClass", 0);
//    class_addProtocol(ProtocolAAdoptingClass, @protocol(ProtocolA));
//
//    id<ProtocolA> obj = [[ProtocolAAdoptingClass alloc] init];
//    
//    XCTAssertTrue([obj conformsToProtocol:@protocol(ProtocolA)], @"Object doesn't conform to protocol");
//    
//    ////////////
//    
//    Proxy *proxy = [[Proxy alloc] init];
//    
//    SEL firstMethod = @selector(firstMethod);
//    NSString *res = [proxy methodForSelector:firstMethod](proxy, firstMethod);
//    
//    XCTAssertNotNil(res, @"Res should return something");
    
    ///////////
    
    Class DynamicDelegate = objc_allocateClassPair([Proxy class], "DelegatingClass", 0);
    class_addProtocol(DynamicDelegate, @protocol(ProtocolA));
    
    id<ProtocolA> dynamicDelegateInstance = [[DynamicDelegate alloc] init];
    ObjectA *objA = [[ObjectA alloc] init];
    objA.delegate = dynamicDelegateInstance;
    
    [[(Proxy *)dynamicDelegateInstance signalForSelector:@selector(firstMethod)] subscribeNext:^(id x) {
        NSLog(@"NEXT");
    }];
    
    [[(Proxy *)dynamicDelegateInstance signalForSelector:@selector(secondMethod:)] subscribeNext:^(id x) {
        NSLog(@"NEXT");
    }];
    [objA startCallingDelegate];
    
    XCTAssertTrue([dynamicDelegateInstance conformsToProtocol:@protocol(ProtocolA)], @"Object doesn't conform to protocol");
}

@end
