//
//  FavoritesList.h
//  Dining@UNL
//
//  Created by Jerrad Thramer on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FoodItem.h"

@interface FavoritesList : NSObject
{
NSMutableArray *favoritesList;

}

-(void) addFavorite:(FoodItem *)item;
-(void) deleteFavorite;
-(void) serializeFavorites;
-(NSMutableArray *) unserializeFavorites;

@end
