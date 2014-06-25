//
//  MessageCardPayView.h
//  IBeacon
//
//  Created by MacBook on 14-6-24.
//  Copyright (c) 2014年 YZB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageCardPayView : UIView<UITextFieldDelegate>

@property (assign, nonatomic) BOOL isZhiFuBao;

@property (weak, nonatomic) IBOutlet UITextField *numberTextfield;

@property (weak, nonatomic) IBOutlet UIButton *backButton;

@property (weak, nonatomic) IBOutlet UIImageView *zhifubaoImageView;

@property (weak, nonatomic) IBOutlet UIImageView *weixinImageView;

@property (weak, nonatomic) IBOutlet UIButton *submitButton;

+ (MessageCardPayView *)getMessageCardPayView;


@end
