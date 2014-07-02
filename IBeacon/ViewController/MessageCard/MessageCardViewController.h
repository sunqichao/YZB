//
//  MessageCardViewController.h
//  IBeacon
//
//  Created by MacBook on 14-6-19.
//  Copyright (c) 2014年 YZB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreModel.h"
#import "AlertView.h"
#import "MessageWebView.h"

@interface MessageCardViewController : UIViewController

@property (strong, nonatomic) MessageWebView *webView;
@property (assign, nonatomic) MessageCardType cardType;
@property (weak, nonatomic) StoreModel *dataModel;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *shouKuanFang;
@property (copy, nonatomic) NSString *price;
@property (strong, nonatomic) AlertView *alertView;


@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UIImageView *closeImageView;





@end
