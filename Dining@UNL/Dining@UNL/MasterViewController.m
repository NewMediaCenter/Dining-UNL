//
//  FirstViewController.m
//  Dining@UNL
//
//  Created by Jerrad Thramer on 11/14/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MasterViewController.h"
#import "DiningHallAPIController.h"
#import "MenuViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManager.h>

static int calendarShadowOffset = (int)-20;


@implementation MasterViewController

@synthesize hallList;
@synthesize apiController;
@synthesize menuForDay;
@synthesize tableView;
@synthesize calendar;
@synthesize menuDate;
@synthesize availableDateArray;
@synthesize locationManager;
@synthesize dayButton;


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


- (void)viewDidLoad
{
    
    //Lets get the users current Location -- 
    locationManager = [[CLLocationManager alloc] init];

    if ([CLLocationManager locationServicesEnabled])
    {
        
        [locationManager setDelegate:self];
        [locationManager startUpdatingLocation];
    }
    
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    apiController = [[DiningHallAPIController alloc] init];
    menuDate =  [[NSDate alloc] init]; //init NSdate and load todays date
    hallList = [[NSMutableArray alloc] initWithArray:[apiController getCurrentHalls]];
    availableDateArray = [apiController getAvailableDates];
    [super viewDidLoad];
    NSLog(@"its working");
    // lets make a calandar!
    calendar = 	[[TKCalendarMonthView alloc] init];
    calendar.delegate = self;
    calendar.dataSource = self;
    
    
    
    // Add Calendar to just off the top of the screen so it can later slide down
    calendar.frame = CGRectMake(0, -calendar.frame.size.height+calendarShadowOffset, calendar.frame.size.width, calendar.frame.size.height);
	// Ensure this is the last "addSubview" because the calendar must be the top most view layer	
	[self.view addSubview:self.calendar];
	[calendar reload];
    [self setTitle: @"Menu For Today"];
    [TestFlight passCheckpoint:@"AppLaunchedCorrectly"];
    
}

- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section 
{
    return [hallList count];
}



- (UITableViewCell *)tableView:(UITableView *)theTableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    // Check for a reusable cell first, use that if it exists
    UITableViewCell *cell =
    [theTableView dequeueReusableCellWithIdentifier:@"HallCell"];
    
    // If there is no reusable cell of this type, create a new one
    if (!cell) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:@"HallCell"];
    }
    
    // Set the text on the cell with the description of the possession
    // that is at the nth index of possessions, where n = row this cell
    // will appear in on the tableview
    Hall *h = [hallList objectAtIndex:[indexPath row]];
    
    
    [[cell textLabel] setText:[h hallName]];
    NSString *detailString = [NSString stringWithFormat:@"%i", [h distanceFromCurrentLocation]];
    [[cell detailTextLabel] setText: [detailString stringByAppendingString:@" m away"]];
    
   
    
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
//{
//    Hall *theHall = [hallList objectAtIndex:indexPath.row];
//   
//    menuForDay = [apiController getMealForTodaywithHall:theHall];
//    NSLog(@"Debug foodForDay: %@", [menuForDay description]);
//    
//}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showMenuForHall"]) {
        MenuViewController *detailViewController = [segue destinationViewController];
        
      //  NSLog(@"THIS CODE WAS EXECUTED!!!");
        
        Hall *theHall = [hallList objectAtIndex:[self->tableView indexPathForSelectedRow].row];
        menuForDay = [apiController getMealForDay:menuDate withHall:theHall];
        [detailViewController setHallMenu:menuForDay];
        [TestFlight passCheckpoint:@"SelectedHall"];
        

    }
}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    for (Hall* currentHall in hallList)
    {
        
        int distance = [newLocation distanceFromLocation:[currentHall hallCoord]];
        [currentHall setDistanceFromCurrentLocation: distance];
        NSLog(@"Distance: %i", distance);
    }
    
    
    [hallList sortUsingSelector:@selector(compareDistance:)];
    [tableView reloadData];
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


#pragma mark TK Cal Begin
- (IBAction)toggleCalendar {
    NSLog(@"CAL TOGGLE");
    
	// If calendar is off the screen, show it, else hide it (both with animations)
	if (calendar.frame.origin.y == -calendar.frame.size.height+calendarShadowOffset) {
		// Show
        [dayButton setTitle:@"Close Calendar"];
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:.75];
		calendar.frame = CGRectMake(0, 0, calendar.frame.size.width, calendar.frame.size.height);
		[UIView commitAnimations];
	} else {
		// Hide
        [dayButton setTitle:@"Day..."];
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:.75];
		calendar.frame = CGRectMake(0, -calendar.frame.size.height+calendarShadowOffset, calendar.frame.size.width, calendar.frame.size.height);		
		[UIView commitAnimations];
	}	
    [TestFlight passCheckpoint:@"CalToggled"];
}

#pragma mark -
#pragma mark TKCalendarMonthViewDelegate methods

- (void)calendarMonthView:(TKCalendarMonthView *)monthView didSelectDate:(NSDate *)d {
	if ([availableDateArray containsObject:d])
    {
    
    NSLog(@"Date Selected: %@", d);
    [self setMenuDate:d];
    NSLog(@"Menu Date Now: %@", menuDate);
    [NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehavior10_4];
   
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [dateFormatter setDateFormat:@"MM-dd"];
    NSLog(@"DF OUT: %@", [dateFormatter stringFromDate:d]);
    NSString *titleString = [[NSString alloc ] initWithFormat:@"Menu For %@", [dateFormatter stringFromDate:d]];
    [self setTitle: titleString];
    [self toggleCalendar];
    }
    else {
        bool shown = false;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Data For That Day" message:@"There is no data for the day you selected. Please select another day." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        if (!shown) {
            shown = true;
            [alert show];
            [monthView selectDate:menuDate];
            [alert release]; 
            [TestFlight passCheckpoint:@"SelectedBadDate"];
        }
        return;
    }
    
}

- (void)calendarMonthView:(TKCalendarMonthView *)monthView monthDidChange:(NSDate *)d {
	NSLog(@"calendarMonthView monthDidChange");	
}

#pragma mark -
#pragma mark TKCalendarMonthViewDataSource methods

- (NSArray*)calendarMonthView:(TKCalendarMonthView *)monthView marksFromDate:(NSDate *)startDate toDate:(NSDate *)lastDate {	
    NSLog(@"calendarMonthView marksFromDate toDate");	
	NSLog(@"Make sure to update 'data' variable to pull from CoreData, website, User Defaults, or some other source.");
	// When testing initially you will have to update the dates in this array so they are visible at the
	// time frame you are testing the code.

	
    
	// Initialise empty marks array, this will be populated with TRUE/FALSE in order for each day a marker should be placed on.
	NSMutableArray *marks = [NSMutableArray array];
	
	// Initialise calendar to current type and set the timezone to never have daylight saving
	NSCalendar *cal = [NSCalendar currentCalendar];
	[cal setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
	
	// Construct DateComponents based on startDate so the iterating date can be created.
	// Its massively important to do this assigning via the NSCalendar and NSDateComponents because of daylight saving has been removed 
	// with the timezone that was set above. If you just used "startDate" directly (ie, NSDate *date = startDate;) as the first 
	// iterating date then times would go up and down based on daylight savings.
	NSDateComponents *comp = [cal components:(NSMonthCalendarUnit | NSMinuteCalendarUnit | NSYearCalendarUnit | 
                                              NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSSecondCalendarUnit) 
                                    fromDate:startDate];
	NSDate *d = [cal dateFromComponents:comp];
	
	// Init offset components to increment days in the loop by one each time
	NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
	[offsetComponents setDay:1];	
	
    
	// for each date between start date and end date check if they exist in the data array
	while (YES) {
		// Is the date beyond the last date? If so, exit the loop.
		// NSOrderedDescending = the left value is greater than the right
		if ([d compare:lastDate] == NSOrderedDescending) {
			break;
		}
		
		// If the date is in the data array, add it to the marks array, else don't
		if ([availableDateArray containsObject:d]) {
			[marks addObject:[NSNumber numberWithBool:YES]];
		} else {
			[marks addObject:[NSNumber numberWithBool:NO]];
		}
		
		// Increment day using offset components (ie, 1 day in this instance)
		d = [cal dateByAddingComponents:offsetComponents toDate:d options:0];
	}
	
	[offsetComponents release];
	
	return [NSArray arrayWithArray:marks];
}

#pragma mark Feedback Launcher

-(IBAction)launchFeedback {
    [TestFlight openFeedbackView];
}

@end
