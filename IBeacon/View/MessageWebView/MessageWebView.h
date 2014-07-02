//
//  MessageWebView.h
//  IBeacon
//
//  Created by MacBook on 14-6-30.
//  Copyright (c) 2014年 YZB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageWebView : UIView




@property (weak, nonatomic) IBOutlet UILabel *title;


@property (weak, nonatomic) IBOutlet UIWebView *mainWebView;



+ (MessageWebView *)getMessageWebView;




@end
