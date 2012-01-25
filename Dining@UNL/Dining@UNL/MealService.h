//
//  MealService.h
//  Dining@UNL
//
//  Created by Jerrad Thramer on 1/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//



@interface MealService : NSObject
{
    NSDate *serviceStartTime;
    NSDate *serviceEndTime;
    NSMutableArray *sectionArray;
}

@property (nonatomic, retain) NSDate *serviceStartTime;
@property (nonatomic, retain) NSDate *serviceEndTime;
@property (nonatomic, retain) NSMutableArray *sectionArray;

@end
