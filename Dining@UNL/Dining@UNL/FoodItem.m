//
//  FoodItem.m
//  Dining@UNL
//
//  Created by Jerrad Thramer on 12/1/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "FoodItem.h"

@implementation FoodItem

-(NSString *)description
{
    return [NSString stringWithString:(@"FoodItem: %@ | %@ /n", itemID , itemName)];
    
}
@synthesize itemID;
@synthesize itemName;

@end
