//
//  KeyViewController.m
//  Dining@UNL
//
//  Created by Jerrad Thramer on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KeyViewController.h"

@implementation KeyViewController
@synthesize imageToLoad;
@synthesize imageView;


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
    //KeyViewController *keyViewController = [segue destinationViewController];
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    // NSLog(@"Orientation: %h", orientation);
    if (UIInterfaceOrientationIsPortrait(orientation))
    {
        self.imageToLoad = [UIImage imageNamed:@"Key320.png"];
        imageView.contentMode = UIViewContentModeBottom;
        imageView.frame = CGRectMake(0, 224, 320, 236);
        
    }
    else if (UIInterfaceOrientationIsLandscape(orientation))
    {
       self.imageToLoad = [UIImage imageNamed:@"KeyLandscape.png"]; 
        imageView.contentMode = UIViewContentModeBottom;
        imageView.frame = CGRectMake(0, self.view.frame.size.height / 2, self.view.frame.size.width, self.view.frame.size.height / 2);
        
        
    } else {
        [NSException raise:NSInvalidArgumentException format:@"A orientation was detected that was not part of the four possible choices. This should never happen."];
    }
    [[self imageView] setNeedsDisplay];
    
    if (imageToLoad) self.imageView.image = imageToLoad;
    else
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
    return (toInterfaceOrientation != (UIInterfaceOrientationLandscapeLeft | UIInterfaceOrientationLandscapeRight));
}
@end
