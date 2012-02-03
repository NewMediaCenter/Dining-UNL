//
//  ServiceDay.h
//  Dining@UNL
//
//  Created by Jerrad Thramer on 1/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import "MealService.h"
@interface ServiceDay : NSObject
{
    NSDate *serviceDate;
    MealService *breakfast;
    MealService *lunch;
    MealService *dinner;
    
    
}
-(NSString *)description ;

@property (nonatomic, retain) NSDate *serviceDate;
@property (nonatomic, retain) MealService *breakfast;
@property (nonatomic, retain) MealService *lunch;
@property (nonatomic, retain) MealService *dinner;
@end
