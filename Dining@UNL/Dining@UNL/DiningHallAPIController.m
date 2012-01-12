//
//  DiningHallAPIController.m
//  Dining@UNL
//
//  Created by Jerrad Thramer on 1/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DiningHallAPIController.h"

@implementation DiningHallAPIController

static DiningHallAPIController *sharedController;

+ (void)initialize
{
    static BOOL initialized = NO;
    if(!initialized)
    {
        initialized = YES;
        sharedController = [[DiningHallAPIController alloc] init];
    }
}

@end
