//
//  CardView.h
//  IBeacon
//
//  Created by MacBook on 14-7-8.
//  Copyright (c) 2014年 YZB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *headerImage;      //商店头像
@property (weak, nonatomic) IBOutlet UIImageView *contentImage;     //海报图片
@property (weak, nonatomic) IBOutlet UIImageView *background;       //
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;           //特卖名字
@property (weak, nonatomic) IBOutlet UILabel *storeName;            //商店名字
@property (weak, nonatomic) IBOutlet UITextView *contentText;       //特卖描述内容



+ (CardView *)getCardView;

@end
