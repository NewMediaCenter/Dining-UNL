//
//  KeyViewController.m
//  Dining@UNL
//
//  Created by Jerrad Thramer on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KeyViewController.h"

@implementation KeyViewController

//@synthesize gestureRecog;
- (void)viewDidLoad
{
    
	[super viewDidLoad];
    NSLog(@"Key loaded.");
    
 
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



- (IBAction)dismissView:(id)sender 
{
    NSLog(@"DONE.");
    [self dismissModalViewControllerAnimated:YES];
}

- (BOOL) shouldAutorotateToInterfaceOrientation:
(UIInterfaceOrientation)toInterfaceOrientation 
{
    return YES;
}
@end
