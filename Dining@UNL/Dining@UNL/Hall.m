//
//  Hall.m
//  Dining@UNL
//
//  Created by Jerrad Thramer on 1/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Hall.h"


@implementation Hall

-(id)init
{
    if (self = [super init])
    {
        days = [[NSMutableArray alloc] init];
        [hallCoord init];
        
        
        
    }
    return self;
}
-(NSString *)description
{
    NSMutableString *result = [[NSMutableString alloc] initWithString:@" == HALL START == \n"];
    [result appendFormat:(@"HALL NAME: %@ \n", [hallName description])];
    [result appendFormat:(@"HALL ID: %@ \n\n", [NSString stringWithFormat:@"%d", hallID])];
    [result appendFormat:(@"HALL COORD: %@ \n\n", [hallCoord description])];
    [result appendFormat:(@"-DAYS ARRAY START-: \n %@ \n -DAYS SECTION ARRAY- \n",
                          [days description])];
    [result appendFormat:(@" == HALL END == \n")]; 
    return result;
    
}

- (NSComparisonResult)compareDistance:(id)otherObject
{
    if ([self distanceFromCurrentLocation] > [otherObject distanceFromCurrentLocation]) {
        return NSOrderedDescending;
    } else if ([self distanceFromCurrentLocation] < [otherObject distanceFromCurrentLocation]) {
        return NSOrderedAscending;
    } else {
        return NSOrderedSame;
    }
}
@synthesize days;
@synthesize hallCoord;
@synthesize hallName;
@synthesize hallID;
@synthesize distanceFromCurrentLocation;

@end
