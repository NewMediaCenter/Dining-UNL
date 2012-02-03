//
//  Hall.m
//  Dining@UNL
//
//  Created by Jerrad Thramer on 1/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Hall.h"


@implementation Hall
-(NSString *)description
{
    NSMutableString *result = [[NSMutableString alloc] initWithString:@" == HALL START == \n"];
    [result appendString:(@"HALL NAME: %@ \n", [hallName description])];
    [result appendString:(@"HALL ID: %@ \n\n", [NSString stringWithFormat:@"%d", hallID])];
    [result appendString:(@"HALL COORD: %@ \n\n", [hallCoord description])];
    [result appendString:(@"-DAYS ARRAY START-: \n %@ \n -DAYS SECTION ARRAY- \n",
                          [days description])];
    [result appendString:(@" == HALL END == \n")]; 
    return result;
    
}
@synthesize days;
@synthesize hallCoord;
@synthesize hallName;
@synthesize hallID;
@end
