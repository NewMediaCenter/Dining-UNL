//
//  SecondViewController.h
//  Dining@UNL
//
//  Created by Jerrad Thramer on 11/14/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceDay.h"

@interface MenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    ServiceDay *hallMenu;
    IBOutlet UITableView *menuView;
}


@property (nonatomic, retain) ServiceDay *hallMenu;

@end
