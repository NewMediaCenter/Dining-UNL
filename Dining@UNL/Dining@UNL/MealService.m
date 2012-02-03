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
-(NSString *)description
{
    NSMutableString *result = [[NSMutableString alloc] initWithString:@" == MEAL SERVICE START == \n"];
    [result appendString:(@"SERVICE START TIME: %@ \n", [serviceStartTime description])];
    [result appendString:(@"SERVICE END TIME: %@ \n\n", [serviceEndTime description])];
    [result appendString:(@"-SECTION ARRAY START-: \n %@ \n -END SECTION ARRAY- \n",
                          [sectionArray description])];
    [result appendString:(@" == MEAL SERVICE END == \n")]; 
     return result;
     
}
@synthesize sectionArray;
@synthesize serviceEndTime;
@synthesize serviceStartTime;

@end
