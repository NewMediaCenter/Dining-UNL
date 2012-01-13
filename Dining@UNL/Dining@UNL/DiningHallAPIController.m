//
//  DiningHallAPIController.m
//  Dining@UNL
//
//  Created by Jerrad Thramer on 1/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DiningHallAPIController.h"
#import "TBXML.h"

@implementation DiningHallAPIController

static DiningHallAPIController *sharedController;

+ (void)initialize
{
    static BOOL initialized = NO;
    if(!initialized)
    {
        initialized = YES;
        sharedController = [[DiningHallAPIController alloc] init];
    }
}

// Gets Current List of halls, and returns list as a NSMutableArray
- (NSMutableArray *) getCurrentHalls 
{
    TBXML * tbxml = [[TBXML tbxmlWithURL:[NSURL URLWithString:@"http://histestiis.unl.edu/menus/services/DailyMenu.aspx?action=getcomplexes"]]]; // Lets load the XML...
    
    NSMutableArray *hallList = [[NSMutableArray alloc] init]; // Init our array containing our halls
    
    
    TBXMLElement *currentElement = [TBXML childElementNamed:@"getcomplexes" parentElement:tbxml.rootXMLElement];
    
    while (currentElement){
        TBXMLElement *idElement = [TBXML childElementNamed:@"ComplexId" parentElement:currentElement];  // lets get the Element for the Hall's ID...
        TBXMLElement *nameElement = [TBXML childElementNamed:@"ComplexName" parentElement:currentElement]; // And the name...

        // and the strings...
        int hallID = [[TBXML textForElement:idElement] intValue];
        NSString *hallName = [TBXML textForElement:nameElement];
        
        //now, lets populate our hall object...
        Hall *currentHall = [[Hall alloc] init];
        [currentHall setHallName:hallName];
        currentHall.hallID = hallID;
        
        //and lets add it to the array
        [hallList addObject:currentHall];
        
        //finally, we clean up...
        currentHall = nil;
        hallName = nil;
        idElement = nil;
        nameElement = nil;
        
        //and load the next element
        currentElement = [TBXML nextSiblingNamed:@"getcomplexes" searchFromElement:tbxml.rootXMLElement];        
        
        
        
    }
    
    return hallList;
    
    
}






- (ServiceDay *) getMealForTodaywithHall:(Hall *)theHall
{
    NSDate *today = [NSDate date]; //init NSdate and load todays date
    TBXML * tbxml = [[TBXML tbxmlWithURL:[NSURL URLWithString:@"http://www.w3schools.com/XML/note.xml"]] retain];
}

@end
