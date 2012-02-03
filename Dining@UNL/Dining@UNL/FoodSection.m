//
//  FoodSection.m
//  Dining@UNL
//
//  Created by Jerrad Thramer on 1/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FoodSection.h"

@implementation FoodSection

-(id)init
{
    if (self = [super init])
    {
        foodItems = [[NSMutableArray alloc] init];
        
        
    }
    return self;
}
-(NSString *)description
{
    NSMutableString *result = [[NSMutableString alloc] initWithString:@" == FOOD SECTION START == \n"];
    [result appendFormat:(@"FOOD SECTION NAME: %@ \n", foodSectionName)];
    [result appendFormat:(@"-FOOD SECTION ITEMS-: \n %@ \n -END FOOD SECTION ITEMS- \n",
                          [foodItems description])];
    [result appendFormat:(@" == FOOD SECTION END == \n")]; 
    return result;
    
}
@synthesize foodSectionName;
@synthesize foodItems;
@end
