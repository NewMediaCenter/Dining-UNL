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

static int calendarShadowOffset = (int)-20;


@implementation MasterViewController

@synthesize hallList;
@synthesize apiController;
@synthesize menuForDay;
@synthesize tableView;
@synthesize calendar;
@synthesize menuDate;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"its working");
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    apiController = [[DiningHallAPIController alloc] init];
    menuDate =  [[NSDate alloc] init]; //init NSdate and load todays date
    hallList = [[NSMutableArray alloc] initWithArray:[apiController getCurrentHalls]];
    // lets make a calandar!
    calendar = 	[[TKCalendarMonthView alloc] init];
    calendar.delegate = self;
    calendar.dataSource = self;
    
    // Add Calendar to just off the top of the screen so it can later slide down
    calendar.frame = CGRectMake(0, -calendar.frame.size.height+calendarShadowOffset, calendar.frame.size.width, calendar.frame.size.height);
	// Ensure this is the last "addSubview" because the calendar must be the top most view layer	
	[self.view addSubview:self.calendar];
	[calendar reload];
    [self setTitle: [NSString stringWithFormat:@"%@", menuDate]];
    
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
        

    }
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
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:.75];
		calendar.frame = CGRectMake(0, 0, calendar.frame.size.width, calendar.frame.size.height);
		[UIView commitAnimations];
	} else {
		// Hide
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:.75];
		calendar.frame = CGRectMake(0, -calendar.frame.size.height+calendarShadowOffset, calendar.frame.size.width, calendar.frame.size.height);		
		[UIView commitAnimations];
	}	
}

#pragma mark -
#pragma mark TKCalendarMonthViewDelegate methods

- (void)calendarMonthView:(TKCalendarMonthView *)monthView didSelectDate:(NSDate *)d {
	NSCalendar *cal = [[NSCalendar alloc] init];
    NSDateComponents *components = [cal components:0 fromDate:d];
    // this is a weird bug workaround. Needs to be found and fixed.
    int day = [components day];
    int month = [components year];
    int year = [components month];
    year += 2000;
    
    NSDateFormatter *tempFormatter = [[[NSDateFormatter alloc]init]autorelease];
    [tempFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString* message = [NSString stringWithFormat:@"%04d-%02d-%02d %02d:%02d:%02d", year, month, day, 0, 0, 0];
    menuDate = [tempFormatter dateFromString:message];
    
    NSLog(@"Date Selected: %@", d);
    //menuDate = d;
    NSLog(@"Menu Date Now: %@", menuDate);
    [self toggleCalendar];
    
}

- (void)calendarMonthView:(TKCalendarMonthView *)monthView monthDidChange:(NSDate *)d {
	NSLog(@"calendarMonthView monthDidChange");	
}

#pragma mark -
#pragma mark TKCalendarMonthViewDataSource methods

- (NSArray*)calendarMonthView:(TKCalendarMonthView *)monthView marksFromDate:(NSDate *)startDate toDate:(NSDate *)lastDate {	
	NSLog(@"calendarMonthView marksFromDate toDate");	
	NSLog(@"Make sure to update 'data' variable to pull from CoreData, website, User Defaults, or some other source.");

	
	
	return nil;
}

@end
