//
//  CardView.m
//  IBeacon
//
//  Created by MacBook on 14-7-8.
//  Copyright (c) 2014年 YZB. All rights reserved.
//

#import "CardView.h"

@implementation CardView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}


- (void)setMask
{
    
}



+ (CardView *)getCardView
{
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"CardView" owner:self options:nil];
    CardView *card = nibs[0];
    return card;
}





@end
