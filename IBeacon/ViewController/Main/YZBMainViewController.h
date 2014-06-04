//
//  YZBMainViewController.h
//  IBeacon
//
//  Created by MacBook on 14-6-4.
//  Copyright (c) 2014年 YZB. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YZBMainViewController;
@protocol YZBMainTapMenuButtonDelegate <NSObject>

/**
 *  点击菜单按钮的回调方法，使出现menuview。
 *
 *  @param controller 返回self
 */
- (void)YZBMainViewDidTapMenuButton:(YZBMainViewController *)controller;

@end

@interface YZBMainViewController : UIViewController

@property (nonatomic, assign) id<YZBMainTapMenuButtonDelegate>delegate;


@end
