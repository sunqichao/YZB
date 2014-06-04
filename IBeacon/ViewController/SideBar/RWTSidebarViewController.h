//
//  RWTSidebarViewController.h
//  Sidebar
//
//  Created by Main Account on 5/1/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RWTSidebarViewController : UIViewController

- (instancetype)initWithLeftViewController:(UIViewController *)leftViewController mainViewController:(UIViewController *)mainViewController gap:(NSInteger)gap;
- (void)toggleMenu;

@end
