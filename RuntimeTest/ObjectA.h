//
//  ObjectA.h
//  RuntimeTest
//
//  Created by Alex Manarpies on 24/01/14.
//  Copyright (c) 2014 Ace on Tech. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol ProtocolA;

@interface ObjectA : NSObject
@property (nonatomic,weak) id<ProtocolA> delegate;

- (void)startCallingDelegate;

@end
