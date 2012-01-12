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

- (Hall *) getCurrentHalls;

- (ServiceDay *) getMealForDay:(ServiceDay *)day withHall:(Hall *)theHall;

- (ServiceDay *) getMealForDay:(ServiceDay *)day withHall:(Hall *)theHall forMeal:(MealService *)meal;

- (NSMutableArray *) checkFavorites:(NSMutableArray *)favoritesList;




@end
