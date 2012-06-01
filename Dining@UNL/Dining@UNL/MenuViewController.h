//
//  SecondViewController.h
//  Dining@UNL
//
//  Created by Jerrad Thramer on 11/14/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceDay.h"
#import "FoodSection.h"
#import "FoodItem.h"
#import "TestFlight.h"
#define NSLog(__FORMAT__, ...) TFLog((@"%s [Line %d] " __FORMAT__), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

@interface MenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    ServiceDay *hallMenu;
    IBOutlet UITableView *menuView;
    NSString *currentService;
    IBOutlet UISegmentedControl *serviceChooser;
    SEL serviceSelector;
    IBOutlet UIButton *helpButton;
    IBOutlet UIImageView *imageView;

}

-(IBAction) serviceSelectorDidChange;
-(IBAction) didSelectHelp;

@property (nonatomic, retain) NSString *currentService;
@property (nonatomic, retain) IBOutlet UISegmentedControl *serviceChooser;
@property (nonatomic, retain) ServiceDay *hallMenu;
@property (nonatomic, retain) IBOutlet UIButton *helpButton;


@end
