//
//  AlertView.m
//  IBeacon
//
//  Created by MacBook on 14-6-30.
//  Copyright (c) 2014年 YZB. All rights reserved.
//

#import "AlertView.h"

@implementation AlertView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}









+ (AlertView *)getAlertView
{
    
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"AlertView" owner:self options:nil];
    AlertView *alert = nibs[0];
    [alert addSubview:alert.backImage];
    [alert addSubview:alert.title];
    return alert;
}






@end
