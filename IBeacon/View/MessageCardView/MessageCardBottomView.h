//
//  MessageCardBottomView.h
//  IBeacon
//
//  Created by MacBook on 14-6-19.
//  Copyright (c) 2014年 YZB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreModel.h"

@interface MessageCardBottomView : UIView

@property (weak, nonatomic) StoreModel *dataModel;

+ (MessageCardBottomView *)getMessageCardBottomView;


@end
