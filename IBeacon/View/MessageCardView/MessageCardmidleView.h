//
//  MessageCardmidleView.h
//  IBeacon
//
//  Created by MacBook on 14-6-19.
//  Copyright (c) 2014年 YZB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreModel.h"

@interface MessageCardmidleView : UIView


@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *description;
@property (weak, nonatomic) IBOutlet UIButton *midButton;


- (void)setData:(StoreModel *)data;


/**
 *  c02c      e08b     eab10    96749
 */

+ (MessageCardmidleView *)getMessageCardmidleView;

@end
