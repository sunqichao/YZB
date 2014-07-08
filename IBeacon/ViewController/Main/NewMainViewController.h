//
//  NewMainViewController.h
//  IBeacon
//
//  Created by MacBook on 14-7-7.
//  Copyright (c) 2014年 YZB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZBMainViewController.h"
@class NewMainViewController;
@protocol NewMainButtonDelegate <NSObject>

/**
 *  点击菜单按钮的回调方法，使出现menuview。
 *
 *  @param controller 返回self
 */
- (void)NewMainViewDidTapMenuButton:(NewMainViewController *)controller;

@end
@interface NewMainViewController : UIViewController



@property (weak, nonatomic) IBOutlet UIImageView *headerImage;



@property (nonatomic, assign) id<NewMainButtonDelegate>delegate;




@end
