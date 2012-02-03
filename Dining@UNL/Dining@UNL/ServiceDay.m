//
//  ServiceDay.m
//  Dining@UNL
//
//  Created by Jerrad Thramer on 1/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ServiceDay.h"

@implementation ServiceDay

-(NSString *)description
{
    NSMutableString *result = [[NSMutableString alloc] initWithString:@" ==SERVICE DAY START == \n"];
    [result appendString:(@"SERVICE DATE: %@ \n", [serviceDate description])];
    [result appendString:(@"-BREAKFAST START-: \n %@ \n -END BREAKFAST- \n",
                          [breakfast description])];
    [result appendString:(@"-LUNCH START-: \n %@ \n -END LUNCH- \n",
                          [lunch description])];
    [result appendString:(@"-DINNER START-: \n %@ \n -END DINNER- \n",
                          [dinner description])];
    [result appendString:(@" == HALL END == \n")]; 
    return [NSString stringWithString:result];
    
}
@synthesize serviceDate;
@synthesize breakfast;
@synthesize lunch;
@synthesize dinner;

@end
