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
    int hallID;
    
    
}
-(NSString *)description;
@property (nonatomic, retain) NSString *hallName;
@property (nonatomic, retain) CLLocation *hallCoord;
@property (nonatomic, retain) NSMutableArray *days;
@property (readwrite, assign) int hallID;

@end
