//
//  ServiceDay.m
//  Dining@UNL
//
//  Created by Jerrad Thramer on 1/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ServiceDay.h"

@implementation ServiceDay
-(id)init
{
    if (self = [super init])
    {
        
        breakfast = [[MealService alloc] init];
        lunch = [[MealService alloc] init];
        dinner = [[MealService alloc] init];
        
        
    }
    return self;
}


-(NSString *)description
{
    NSMutableString *result = [[NSMutableString alloc] initWithString:@" ==SERVICE DAY START == \n"];
    [result appendFormat:(@"SERVICE DATE: %@ \n", [serviceDate description])];
    [result appendFormat:(@"-BREAKFAST START-: \n %@ \n -END BREAKFAST- \n",
                          [breakfast description])];
    [result appendFormat:(@"-LUNCH START-: \n %@ \n -END LUNCH- \n",
                          [lunch description])];
    [result appendFormat:(@"-DINNER START-: \n %@ \n -END DINNER- \n",
                          [dinner description])];
    [result appendFormat:(@" == HALL END == \n")]; 
    return [NSString stringWithString:result];
    
}
@synthesize serviceDate;
@synthesize breakfast;
@synthesize lunch;
@synthesize dinner;

@end
