//
//  KeyViewController.h
//  Dining@UNL
//
//  Created by Jerrad Thramer on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface KeyViewController : UIViewController <UIGestureRecognizerDelegate, UIActionSheetDelegate>
{
   // IBOutlet UIGestureRecognizer *gestureRecog;
    IBOutlet UIImageView *imageView;
    UIImage *imageToLoad;
}
//@property (nonatomic, retain) IBOutlet UIGestureRecognizer *gestureRecog;

@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain)  UIImage *imageToLoad;
- (IBAction)dismissView:(id)sender;

@end
