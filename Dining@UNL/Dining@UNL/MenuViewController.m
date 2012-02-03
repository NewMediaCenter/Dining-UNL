//
//  SecondViewController.m
//  Dining@UNL
//
//  Created by Jerrad Thramer on 11/14/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MenuViewController.h"

@implementation MenuViewController
@synthesize hallMenu;
@synthesize currentService;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
	[super viewDidLoad];
    NSLog(@"Menu Side Working");
    [menuView setDelegate:self];
    [menuView setDataSource:self];
    currentService = @"Lunch";
    
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return [hallMenu.lunch.sectionArray count];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    FoodSection *currentSection = [hallMenu.lunch.sectionArray objectAtIndex:section];
    return [currentSection foodSectionName];
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    FoodSection *currentSection = [hallMenu.lunch.sectionArray objectAtIndex:section];
    return [[currentSection foodItems] count];
}

- (UITableViewCell *)tableView:(UITableView *)theTableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    // Check for a reusable cell first, use that if it exists
    UITableViewCell *cell =
    [theTableView dequeueReusableCellWithIdentifier:@"MenuCell"];
    
    // If there is no reusable cell of this type, create a new one
    if (!cell) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:@"MenuCell"];
    }
    
    // Set the text on the cell with the description of the possession
    // that is at the nth index of possessions, where n = row this cell
    // will appear in on the tableview
    FoodSection *s = [hallMenu.lunch.sectionArray objectAtIndex:[indexPath section]] ;
    FoodItem *f = [[s foodItems] objectAtIndex:[indexPath row]];
    
    [[cell textLabel] setText:[f itemName]];
    
    
    
    return cell;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
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

@end
