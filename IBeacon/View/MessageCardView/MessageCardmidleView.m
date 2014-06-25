//
//  MessageCardmidleView.m
//  IBeacon
//
//  Created by MacBook on 14-6-19.
//  Copyright (c) 2014年 YZB. All rights reserved.
//

#import "MessageCardmidleView.h"

@implementation MessageCardmidleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setData:(StoreModel *)data
{
    self.title.text = data.title;
    self.description.text = data.subtitle;
    
}

+ (MessageCardmidleView *)getMessageCardmidleView
{
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"MessageCardmidleView" owner:self options:nil];
    MessageCardmidleView *view = nibs[0];
    return view;

}


@end
