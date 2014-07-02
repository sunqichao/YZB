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


@property (weak, nonatomic) IBOutlet UILabel *zanLabel;

@property (weak, nonatomic) IBOutlet UILabel *collectionLabel;

@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@property (weak, nonatomic) IBOutlet UILabel *shareLabel;

@property (assign, nonatomic) BOOL isZan;

@property (assign, nonatomic) BOOL isCollection;

@property (weak, nonatomic) StoreModel *dataModel;


- (void)setUpNumber;

+ (MessageCardBottomView *)getMessageCardBottomView;


@end
