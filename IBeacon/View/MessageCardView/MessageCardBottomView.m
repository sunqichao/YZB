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
        [self getNumber];
    }
}

- (void)getNumber
{
    [self.dataModel getZanMessageInformationWithBlock:^(NSDictionary *data, NSError *error) {
        [self.dataModel setNumbers:data];
        [self setUpNumber];
    }];
}

- (void)setUpNumber
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.zanLabel.text = self.dataModel.APPROVESUM;
        self.collectionLabel.text = self.dataModel.COLLECTSUM;
        self.commentLabel.text = self.dataModel.COMMENTSUM;
        self.shareLabel.text = self.dataModel.SHARESUM;
 
    });
}

- (IBAction)favor:(id)sender {
    NSLog(@"favor");
    if (self.isZan) {
        [self.dataModel cancelZanWithBlock:^(NSDictionary *data, NSError *error) {
        }];
        self.isZan = NO;
        self.zanLabel.text = [NSString stringWithFormat:@"%d",([self.zanLabel.text intValue]-1)];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"appearAlertView" object:nil userInfo:@{@"title":@"赞-1",@"backImage":@"ic_like.png"}];
        
    }else
    {
        [self.dataModel setZanMessageInformationWithType:@"1" commentWord:@"" block:^(NSDictionary *data, NSError *error) {

        }];
        self.isZan = YES;
        self.zanLabel.text = [NSString stringWithFormat:@"%d",([self.zanLabel.text intValue]+1)];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"appearAlertView" object:nil userInfo:@{@"title":@"赞+1",@"backImage":@"ic_like.png"}];


    }
    
}


- (IBAction)collect:(id)sender {
    NSLog(@"collect");
    if (self.isCollection) {
        [self.dataModel cancelCollectionWithBlock:^(NSDictionary *data, NSError *error) {

        }];
        self.isCollection = NO;
        self.collectionLabel.text = [NSString stringWithFormat:@"%d",([self.collectionLabel.text intValue]-1)];

    }else
    {
        [self.dataModel setZanMessageInformationWithType:@"2" commentWord:@"" block:^(NSDictionary *data, NSError *error) {
            
        }];
        self.isCollection = YES;
        self.collectionLabel.text = [NSString stringWithFormat:@"%d",([self.collectionLabel.text intValue]+1)];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"appearAlertView" object:nil userInfo:@{@"title":@"",@"backImage":@"ic_heart.png"}];

    }
}


- (IBAction)comment:(id)sender {
    NSLog(@"comment");
//    [self.dataModel setZanMessageInformationWithType:@"3" commentWord:@"chi,jiao,zi" block:^(NSDictionary *data, NSError *error) {
//        
//    }];
    [self.dataModel getCommentArrayWithPage:1 block:^(NSArray *data, NSError *error) {
        
    }];
}


- (IBAction)share:(id)sender {
    NSLog(@"share");

    
}


+ (MessageCardBottomView *)getMessageCardBottomView
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MessageCardBottomView" owner:self options:nil];
    MessageCardBottomView *view = nib[0];
    view.isZan = NO;
    view.isCollection = NO;
    return view;
}





@end
