//
//  StoreModel.h
//  IBeacon
//
//  Created by MacBook on 14-6-4.
//  Copyright (c) 2014年 YZB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreModel : NSObject

@property (nonatomic, copy) NSString *sid;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;   //商家名称
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *contentURL;
@property (nonatomic, copy) NSString *imageURL;

@property (nonatomic, copy) NSString *APPROVESUM;  //赞数量
@property (nonatomic, copy) NSString *ISCOLLECT;   //是否收藏
@property (nonatomic, copy) NSString *COMMENTSUM;  //评论数量
@property (nonatomic, copy) NSString *ISAPPROVE;   //是否点赞
@property (nonatomic, copy) NSString *SHARESUM;     //分享数量
@property (nonatomic, copy) NSString *COLLECTSUM;   //收藏数量



- (instancetype)initWithAttributes:(NSDictionary *)attributes;


/**
 *  初始化赞，收藏，分享，评论数量的值
 *
 *  @param dic
 */
- (void)setNumbers:(NSDictionary *)dic;

/**
 *  判断插入历史消息中的数据是否是已经在历史数据的数组中存在
 *
 *  @param data 要判断的数据
 *
 *  @return 如果已经存在返回yes
 */
+ (BOOL)isSameHistoryData:(id)data;


/**
 *  根据id获取商店的信息
 *
 *  @param sid   商店id
 *  @param block 回调
 */
+ (void)getStoreInformationWithId:(id)sid block:(void(^)(NSArray *data,NSError *error))block;


- (void)getZanMessageInformationWithBlock:(void(^)(NSDictionary *data,NSError *error))block;


@end
