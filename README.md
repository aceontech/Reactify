# Reactify

Experiment. Turn any delegate-based API into a ReactiveCocoa API.

## Example

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
