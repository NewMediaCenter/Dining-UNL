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


@interface MenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    ServiceDay *hallMenu;
    IBOutlet UITableView *menuView;
    NSString *currentService;
    IBOutlet UISegmentedControl *serviceChooser;
    SEL serviceSelector;

}

-(IBAction) serviceSelectorDidChange;

@property (nonatomic, retain) NSString *currentService;
@property (nonatomic, retain) IBOutlet UISegmentedControl *serviceChooser;
@property (nonatomic, retain) ServiceDay *hallMenu;


@end
