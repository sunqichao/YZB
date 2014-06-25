//
//  MessageCardBottomView.m
//  IBeacon
//
//  Created by MacBook on 14-6-19.
//  Copyright (c) 2014年 YZB. All rights reserved.
//

#import "MessageCardBottomView.h"

@implementation MessageCardBottomView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setDataModel:(StoreModel *)dataModel
{
    if (dataModel) {
        _dataModel = dataModel;
        [self.dataModel getZanMessageInformationWithBlock:^(NSDictionary *data, NSError *error) {
            [self.dataModel setNumbers:data];
        }];
    }
}

- (IBAction)favor:(id)sender {
    NSLog(@"favor");
    
}


- (IBAction)collect:(id)sender {
    NSLog(@"collect");

    
}


- (IBAction)comment:(id)sender {
    NSLog(@"comment");

    
}


- (IBAction)share:(id)sender {
    NSLog(@"share");

    
}


+ (MessageCardBottomView *)getMessageCardBottomView
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MessageCardBottomView" owner:self options:nil];
    MessageCardBottomView *view = nib[0];
    return view;
}





@end
