//
//  MessageCardDetailView.h
//  IBeacon
//
//  Created by MacBook on 14-6-23.
//  Copyright (c) 2014年 YZB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreModel.h"


@interface MessageCardDetailView : UIView


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;

@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;

@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollview;


@property (weak, nonatomic) IBOutlet UIButton *dismissButton;

- (void)setData:(StoreModel *)data;


+ (MessageCardDetailView *)getMessageCardDetailView;


@end
