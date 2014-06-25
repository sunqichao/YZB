//
//  MessageCardPayView.m
//  IBeacon
//
//  Created by MacBook on 14-6-24.
//  Copyright (c) 2014年 YZB. All rights reserved.
//

#import "MessageCardPayView.h"

@implementation MessageCardPayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)clearMethod
{
    [self.numberTextfield resignFirstResponder];
    NSString *number = self.numberTextfield.text;
    NSRange point = [number rangeOfString:@"."];
    if (point.length>0) {
        
    }else
    {
        NSString *numberStr = [NSString stringWithFormat:@"%@.00",number];
        self.numberTextfield.text = numberStr;
    }
}

- (IBAction)dismissTextfield:(id)sender {
    [self clearMethod];
    
}


- (IBAction)choseZhiFuBao:(id)sender {
    self.zhifubaoImageView.image = [UIImage imageNamed:@"choose.png"];
    self.weixinImageView.image = [UIImage imageNamed:@"unchoose.png"];
    self.isZhiFuBao = YES;
    
}

- (IBAction)choseWeiXin:(id)sender {
    self.zhifubaoImageView.image = [UIImage imageNamed:@"unchoose.png"];
    self.weixinImageView.image = [UIImage imageNamed:@"choose.png"];
    self.isZhiFuBao = NO;
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self clearMethod];
    
    return YES;
}


+ (MessageCardPayView *)getMessageCardPayView
{
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"MessageCardPayView" owner:self options:nil];
    MessageCardPayView *payView = nibs[0];
    payView.isZhiFuBao = YES;
    return payView;
}




@end
