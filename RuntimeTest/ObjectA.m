//
//  ObjectA.m
//  RuntimeTest
//
//  Created by Alex Manarpies on 24/01/14.
//  Copyright (c) 2014 Ace on Tech. All rights reserved.
//

#import "ObjectA.h"
#import "ProtocolA.h"

@implementation ObjectA

- (void)startCallingDelegate
{
    [self.delegate firstMethod];
    NSString *str2 = [self.delegate secondMethod:@"a parameter"];
    BOOL boolean = [self.delegate thirdMethod];
    NSString *str = [self.delegate fourthMethod];
    NSLog(@"END");
}

@end
