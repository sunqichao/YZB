//
//  MessageCardDetailView.m
//  IBeacon
//
//  Created by MacBook on 14-6-23.
//  Copyright (c) 2014年 YZB. All rights reserved.
//

#import "MessageCardDetailView.h"

@implementation MessageCardDetailView

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
    self.titleLabel.text = data.title;
    self.subtitleLabel.text = data.subtitle;
    self.contentTextView.text = data.content;
    [self.contentImageView setImageWithURL:[NSURL URLWithString:data.imageURL] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        
    }];
    
    [self.contentTextView sizeToFit];
    self.contentTextView.textColor = [UIColor whiteColor];
    float imageY = self.contentTextView.frame.origin.y+self.contentTextView.frame.size.height;
    self.contentImageView.frame = CGRectMake(self.contentImageView.frame.origin.x,imageY, self.contentImageView.frame.size.width, self.contentImageView.frame.size.height);
    self.contentScrollview.contentSize = CGSizeMake(0, self.contentImageView.frame.origin.y+self.contentImageView.frame.size.height);
}


+ (MessageCardDetailView *)getMessageCardDetailView
{
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"MessageCardDetailView" owner:self options:nil];
    MessageCardDetailView *detail = nibs[0];
    return detail;
}




@end
