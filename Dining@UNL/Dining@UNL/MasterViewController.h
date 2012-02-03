//
//  FirstViewController.h
//  Dining@UNL
//
//  Created by Jerrad Thramer on 11/14/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiningHallAPIController.h"

@interface MasterViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UITableView *tableView;
    NSMutableArray *hallList;
    DiningHallAPIController *apiController;
    ServiceDay *menuForDay;
}
@property (nonatomic, retain) ServiceDay *menuForDay;
@property (nonatomic, retain) NSMutableArray *hallList;
@property (nonatomic, retain) DiningHallAPIController *apiController;

@end
