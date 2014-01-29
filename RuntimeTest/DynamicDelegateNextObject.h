//
//  DynamicDelegateNextObject.h
//  RuntimeTest
//
//  Created by Alex Manarpies on 24/01/14.
//  Copyright (c) 2014 Ace on Tech. All rights reserved.
//

typedef void (^ReturnBlock)(void *returnObject);

@interface DynamicDelegateNextObject : NSObject
@property (nonatomic,strong) NSArray *arguments;
@property (nonatomic,copy) ReturnBlock returnBlock;
@end
