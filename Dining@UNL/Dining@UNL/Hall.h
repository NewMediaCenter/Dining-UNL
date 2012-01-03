//
//  Hall.h
//  Dining@UNL
//
//  Created by Jerrad Thramer on 1/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import <CoreLocation/CoreLocation.h>
@interface Hall : NSObject
{
    NSString *hallName;
    CLLocation *hallCoord;
    NSMutableArray *days;
    
    
}
@end
