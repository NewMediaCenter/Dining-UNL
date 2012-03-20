//
//  DiningHallAPIController.m
//  Dining@UNL
//
//  Created by Jerrad Thramer on 1/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DiningHallAPIController.h"
#import "TBXML.h"
#import <CoreLocation/CLLocation.h>

@implementation DiningHallAPIController

//static DiningHallAPIController *sharedController;



// Gets Current List of halls, and returns list as a NSMutableArray
- (NSMutableArray *) getCurrentHalls 
{
    TBXML * tbxml = [TBXML tbxmlWithURL:[NSURL URLWithString:@"http://histestiis.unl.edu/menus/services/DailyMenu.aspx?action=getcomplexes"]]; // Lets load the XML...
    
    NSMutableArray *hallList = [[NSMutableArray alloc] init]; // Init our array containing our halls
    
    
    TBXMLElement *currentElement = [TBXML childElementNamed:@"getcomplexes" parentElement:tbxml.rootXMLElement];
    
    while (currentElement){
        TBXMLElement *idElement = [TBXML childElementNamed:@"ComplexId" parentElement:currentElement];  // lets get the Element for the Hall's ID...
        TBXMLElement *nameElement = [TBXML childElementNamed:@"ComplexName" parentElement:currentElement]; // And the name...
        
        // and the strings...
        int hallID = [[TBXML textForElement:idElement] intValue];
        NSString *hallName = [TBXML textForElement:nameElement];
        hallName = [hallName stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"]; // lets get rid of HTML...
        //now, lets populate our hall object...
        Hall *currentHall = [[Hall alloc] init];
        [currentHall setHallName:hallName];
        currentHall.hallID = hallID;
        
        TBXMLElement *latitudeElement = [TBXML childElementNamed:@"Latitude" parentElement:currentElement];
        TBXMLElement *longitudeElement = [TBXML childElementNamed:@"Longitude" parentElement:currentElement];
        CLLocationDegrees latitude = [[TBXML textForElement:latitudeElement] doubleValue];
        CLLocationDegrees longitude = [[TBXML textForElement:longitudeElement] doubleValue];
        CLLocation *location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
        [currentHall setHallCoord: location];
        
        
        //and lets add it to the array
        [hallList addObject:currentHall];
        
        //finally, we clean up...
        currentHall = nil;
        hallName = nil;
        idElement = nil;
        nameElement = nil;
        
        //and load the next element
        currentElement = [TBXML nextSiblingNamed:@"getcomplexes" searchFromElement:currentElement];        
        
        NSLog(@"DiningHallAPI is working -- look! %@", [currentHall hallName]);
        
    }
    
    return hallList;
}

- (NSMutableArray *) getAvailableDates
{
    TBXML * tbxml = [TBXML tbxmlWithURL:[NSURL URLWithString:@"http://histestiis.unl.edu/menus/services/DailyMenu.aspx?action=getmealdates"]]; // Lets load the XML...
    NSMutableArray *availableDates = [[NSMutableArray alloc] init]; // Init our array containing our halls
    
    
    TBXMLElement *currentElement = [TBXML childElementNamed:@"getmealdates" parentElement:tbxml.rootXMLElement];
    NSDate *date = [[NSDate alloc] init];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setTimeZone: [NSTimeZone timeZoneForSecondsFromGMT:0]];
    [df setDateFormat:@"MM-dd-yyyy"];
    
    while (currentElement){
        TBXMLElement *dateElement = [TBXML childElementNamed:@"MealDate" parentElement:currentElement];
        
        
        
        date = [df dateFromString: [TBXML textForElement:dateElement]];
        
        [availableDates addObject:date];
        
        currentElement = [TBXML nextSiblingNamed:@"getmealdates" searchFromElement:currentElement];
        
        NSLog(@"Added Date: %@", date);
        
        
    }
    [df setTimeZone:[NSTimeZone timeZoneWithName:@"CST"]];
    return availableDates;
    
}

-(ServiceDay *) getMealForDay:(NSDate *)day withHall:(Hall *)theHall
{
    NSLog(@"Day to be gotten: %@", day);
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MM-dd-yyyy"];
    NSString *uriString =  [NSString stringWithFormat: @"http://histestiis.unl.edu/menus/services/dailymenu.aspx?action=getdailymenuforentireday&complexId=%u&mealdate=%@&Type=hierarchical", 
                            theHall.hallID, [df stringFromDate:day]];
    TBXML * tbxml = nil;
    @try {
        tbxml = [TBXML tbxmlWithURL:[NSURL URLWithString:uriString]];
    }
    @catch (NSException * e) {
        NSLog(@"Exception was cought while trying to load URL. Exception is as follows: %@", e);
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Something Went Wrong!"
                                                          message:@"An Error was generated as we tried to get data from the API. This is probably due to a problem with the Database. Please make another selection or try again later."
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        
        [message show];
        return nil;
    }
    NSLog(@"URI: %@",uriString);
    ServiceDay *resultDay = [[ServiceDay alloc] init];
    TBXMLElement *currentElement = [TBXML childElementNamed:@"UNLDining" parentElement:tbxml.rootXMLElement];
    
    // Lets get the date real quick...
    TBXMLElement *serviceDate = [TBXML childElementNamed:@"ServiceDate" parentElement:tbxml.rootXMLElement];
    
    [df setDateFormat:@"MM-dd-yyyy"];
    //    [df setTimeZone:[NSTimeZone timeZoneWithName:@"CST"]];
    while (currentElement) { 
        
        [resultDay setServiceDate:[df dateFromString: [TBXML textForElement:serviceDate]]];
    }
        
        // while ([tbxml rootXMLElement]){
        
        //Lets Start With Breakfast...
        MealService *breakfast = [[MealService alloc] init];
        TBXMLElement *breakfastRoot = [TBXML childElementNamed:@"Breakfast" parentElement:tbxml.rootXMLElement];
        
        //Lets take care of service times...
        [df setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'-06:00"];
        TBXMLElement *startTimeElement = [TBXML childElementNamed:@"MealStart" parentElement:breakfastRoot];
        TBXMLElement *endTimeElement = [TBXML childElementNamed:@"MealEnd" parentElement:breakfastRoot];
        [breakfast setServiceStartTime: [df dateFromString: [TBXML textForElement:startTimeElement]]];
        [breakfast setServiceEndTime: [df dateFromString: [TBXML textForElement:endTimeElement]]];
        
        
        TBXMLElement *sectionRoot = [TBXML childElementNamed:@"MealCourse" 
                                               parentElement:breakfastRoot];
        
        while (sectionRoot) {
            FoodSection *currentSection = [[FoodSection alloc] init];
            [currentSection setFoodSectionName: [[TBXML valueOfAttributeNamed:@"value" forElement:sectionRoot] stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"]]; // create the section and set the Name of the section, which is a attrib
            
            
            // And now, we finally go over the individual food items.
            TBXMLElement *currentFoodItem = [TBXML childElementNamed:@"FoodItem"
                                                       parentElement:sectionRoot];
            
            while (currentFoodItem) {
                FoodItem *currentItem = [[FoodItem alloc] init];
                // We need to populate the two subelements and get their info...
                TBXMLElement *mealItem = [TBXML childElementNamed:@"MealItem" 
                                                    parentElement:currentFoodItem];
                
                TBXMLElement *mealItemID = [TBXML childElementNamed:@"MealItemId" 
                                                      parentElement:currentFoodItem];
                
                [currentItem setItemName: [[TBXML textForElement:mealItem]stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"]];
                [currentItem setItemID: [[TBXML textForElement:mealItemID] intValue]];
                
                //Cool, lets store the Food item and go to the next one.
                [[currentSection foodItems] addObject:currentItem];
                
                //  currentItem = nil; // we clean up for this item block
                currentFoodItem = [TBXML nextSiblingNamed:@"FoodItem"      
                                        searchFromElement:currentFoodItem]; // get the next one...
            } // End current Food Items Block
            [[breakfast sectionArray] addObject:currentSection];
            //  currentSection = nil;
            sectionRoot = [TBXML nextSiblingNamed:@"MealCourse" 
                                searchFromElement:sectionRoot];
            
            
        } // end food section block
        
        [resultDay setBreakfast:breakfast]; // and finally we store breakfast.
        
        // end breakfast
        
        
        
        // and for lunch...
        MealService *lunch = [[MealService alloc] init];
        TBXMLElement *lunchRoot = [TBXML childElementNamed:@"Lunch" parentElement:tbxml.rootXMLElement];
        
        //Lets take care of service times...
        startTimeElement = [TBXML childElementNamed:@"MealStart" parentElement:lunchRoot];
        endTimeElement = [TBXML childElementNamed:@"MealEnd" parentElement:lunchRoot];
        [lunch setServiceStartTime: [df dateFromString: [TBXML textForElement:startTimeElement]]];
        [lunch setServiceEndTime: [df dateFromString: [TBXML textForElement:endTimeElement]]];
        
        sectionRoot = [TBXML childElementNamed:@"MealCourse" 
                                 parentElement:lunchRoot];
        
        while (sectionRoot) {
            FoodSection *currentSection = [[FoodSection alloc] init];
            [currentSection setFoodSectionName: 
             [TBXML valueOfAttributeNamed:@"value" 
                               forElement:sectionRoot]]; // create the section and set the Name of the section, which is a attrib
            
            
            // And now, we finally go over the individual food items.
            TBXMLElement *currentFoodItem = [TBXML childElementNamed:@"FoodItem"
                                                       parentElement:sectionRoot];
            
            while (currentFoodItem) {
                FoodItem *currentItem = [[FoodItem alloc] init];
                // We need to populate the two subelements and get their info...
                TBXMLElement *mealItem = [TBXML childElementNamed:@"MealItem" 
                                                    parentElement:currentFoodItem];
                
                TBXMLElement *mealItemID = [TBXML childElementNamed:@"MealItemId" 
                                                      parentElement:currentFoodItem];
                
                [currentItem setItemName: [[TBXML textForElement:mealItem]stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"]];
                [currentItem setItemID: [[TBXML textForElement:mealItemID] intValue]];
                
                //Cool, lets store the Food item and go to the next one.
                [[currentSection foodItems] addObject:currentItem];
                
                //  currentItem = nil; // we clean up for this item block
                currentFoodItem = [TBXML nextSiblingNamed:@"FoodItem"      
                                        searchFromElement:currentFoodItem]; // get the next one...
            } // End current Food Items Block
            [[lunch sectionArray] addObject:currentSection];
            //  currentSection = nil;
            sectionRoot = [TBXML nextSiblingNamed:@"MealCourse" 
                                searchFromElement:sectionRoot];
            
            
        } // end food section block
        
        [resultDay setLunch:lunch]; // and finally we store lunch.
        
        // end lunch
        
        // and for dinner...
        MealService *dinner = [[MealService alloc] init];
        TBXMLElement *dinnerRoot = [TBXML childElementNamed:@"Dinner" parentElement:tbxml.rootXMLElement];
        
        
        //Lets take care of service times...
        startTimeElement = [TBXML childElementNamed:@"MealStart" parentElement:dinnerRoot];
        endTimeElement = [TBXML childElementNamed:@"MealEnd" parentElement:dinnerRoot];
        if (startTimeElement && endTimeElement){
            [dinner setServiceStartTime: [df dateFromString: [TBXML textForElement:startTimeElement]]];
            [dinner setServiceEndTime: [df dateFromString: [TBXML textForElement:endTimeElement]]];
        }
        
        sectionRoot = [TBXML childElementNamed:@"MealCourse" 
                                 parentElement:dinnerRoot];
        
        while (sectionRoot) {
            FoodSection *currentSection = [[FoodSection alloc] init];
            [currentSection setFoodSectionName: 
             [TBXML valueOfAttributeNamed:@"value" 
                               forElement:sectionRoot]]; // create the section and set the Name of the section, which is a attrib
            
            
            // And now, we finally go over the individual food items.
            TBXMLElement *currentFoodItem = [TBXML childElementNamed:@"FoodItem"
                                                       parentElement:sectionRoot];
            
            while (currentFoodItem) {
                FoodItem *currentItem = [[FoodItem alloc] init];
                // We need to populate the two subelements and get their info...
                TBXMLElement *mealItem = [TBXML childElementNamed:@"MealItem" 
                                                    parentElement:currentFoodItem];
                
                TBXMLElement *mealItemID = [TBXML childElementNamed:@"MealItemId" 
                                                      parentElement:currentFoodItem];
                
                [currentItem setItemName: [[TBXML textForElement:mealItem]stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"]];
                [currentItem setItemID: [[TBXML textForElement:mealItemID] intValue]];
                
                //Cool, lets store the Food item and go to the next one.
                [[currentSection foodItems] addObject:currentItem];
                
                //  currentItem = nil; // we clean up for this item block
                currentFoodItem = [TBXML nextSiblingNamed:@"FoodItem"      
                                        searchFromElement:currentFoodItem]; // get the next one...
            } // End current Food Items Block
            [[dinner sectionArray] addObject:currentSection];
            //  currentSection = nil;
            sectionRoot = [TBXML nextSiblingNamed:@"MealCourse" 
                                searchFromElement:sectionRoot];
            
            
        } // end food section block
        
        [resultDay setDinner:dinner]; // and finally we store lunch.
        //end dinner
        
        
        
        
        //   } // end day
        NSLog(@"The whole Day!: %@",[resultDay description]);
    
    return resultDay;
}




- (ServiceDay *) getMealForTodaywithHall:(Hall *)theHall
{
    NSDate *today = [NSDate date]; //init NSdate and load todays date
    return [self getMealForDay:today withHall:theHall];
    
}

@end
