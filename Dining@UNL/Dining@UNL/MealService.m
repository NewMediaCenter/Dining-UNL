//
//  MealService.m
//  Dining@UNL
//
//  Created by Jerrad Thramer on 1/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MealService.h"

@implementation MealService
{
    

}
-(id)init
{
    if (self = [super init])
    {
        sectionArray = [[NSMutableArray alloc] init];
        
        
        
    }
    return self;
}
-(NSString *)description
{
    NSMutableString *result = [[NSMutableString alloc] initWithString:@" == MEAL SERVICE START == \n"];
 //   [result appendFormat:(@"SERVICE START TIME: %@ \n", [serviceStartTime description])];
 //   [result appendFormat:(@"SERVICE END TIME: %@ \n\n", [serviceEndTime description])];
    [result appendFormat:(@"-SECTION ARRAY START-: \n %@ \n -END SECTION ARRAY- \n",
                          [sectionArray description])];
    [result appendFormat:(@" == MEAL SERVICE END == \n")]; 
     return result;
     
}
@synthesize sectionArray;
@synthesize serviceEndTime;
@synthesize serviceStartTime;

@end
