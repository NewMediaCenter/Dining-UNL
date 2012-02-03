//
//  FoodSection.h
//  Dining@UNL
//
//  Created by Jerrad Thramer on 1/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//



@interface FoodSection : NSObject
{
    NSString *foodSectionName;
    NSMutableArray *foodItems;
}
-(id)init;
-(NSString *)description;
@property (nonatomic, retain) NSString *foodSectionName;
@property (nonatomic, retain) NSMutableArray *foodItems;

@end
