//
//  AlertView.h
//  IBeacon
//
//  Created by MacBook on 14-6-30.
//  Copyright (c) 2014年 YZB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertView : UIView


@property (weak, nonatomic) IBOutlet UIImageView *backImage;


@property (weak, nonatomic) IBOutlet UILabel *title;


+ (AlertView *)getAlertView;

@end
