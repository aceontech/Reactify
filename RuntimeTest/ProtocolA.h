//
//  SomeProtocol.h
//  RuntimeTest
//
//  Created by Alex Manarpies on 24/01/14.
//  Copyright (c) 2014 Ace on Tech. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ProtocolA <NSObject>

- (void)firstMethod;
- (NSString *)secondMethod:(NSString *)param;
- (BOOL)thirdMethod;
- (NSString *)fourthMethod;

@end
