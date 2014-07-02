//
//  MessageWebView.m
//  IBeacon
//
//  Created by MacBook on 14-6-30.
//  Copyright (c) 2014年 YZB. All rights reserved.
//

#import "MessageWebView.h"

@implementation MessageWebView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}




+ (MessageWebView *)getMessageWebView
{
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"MessageWebView" owner:self options:nil];
    MessageWebView *webView = nibs[0];
    return webView;
}















@end
