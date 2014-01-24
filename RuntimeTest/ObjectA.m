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
    [self.delegate secondMethod:@"a parameter"];
}

@end
