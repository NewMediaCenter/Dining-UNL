//
//  FoodItem.h
//  Dining@UNL
//
//  Created by Jerrad Thramer on 12/1/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodItem : NSObject
{
    int itemID;
    NSString *itemName;
}

@property (nonatomic, retain) NSString* itemName;
@property (nonatomic, readwrite) int itemID;

@end
