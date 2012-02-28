//
//  DiningHallAPIController.h
//  Dining@UNL
//
//  Created by Jerrad Thramer on 1/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import "Hall.h"
#import "ServiceDay.h" 
#import "FoodItem.h"
#import "FoodSection.h"
@interface DiningHallAPIController : NSObject
{
    
}
+ (DiningHallAPIController *)sharedController;

- (NSMutableArray *) getCurrentHalls;

- (ServiceDay *) getMealForDay:(NSDate *)day withHall:(Hall *)theHall;

- (ServiceDay *) getMealForDay:(NSDate *)day withHall:(Hall *)theHall forMeal:(MealService *)meal;

- (ServiceDay *) getMealForTodaywithHall:(Hall *)theHall;

- (NSMutableArray *) checkFavorites:(NSMutableArray *)favoritesList;
- (NSMutableArray *) getAvailableDates;



@end
