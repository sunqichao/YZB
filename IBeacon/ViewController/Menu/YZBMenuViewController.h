//
//  YZBMenuViewController.h
//  IBeacon
//
//  Created by MacBook on 14-6-4.
//  Copyright (c) 2014年 YZB. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YZBMenuViewController;
@protocol YZBMeunViewControllerDelegate <NSObject>

/**
 *  点击关于的回调
 *
 *  @param controller
 */
- (void)menuViewDidTapAbout:(YZBMenuViewController *)controller;

@end

@interface YZBMenuViewController : UIViewController


@property (nonatomic, assign) id <YZBMeunViewControllerDelegate>delegate;


@end
