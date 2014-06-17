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
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *contentURL;
@property (nonatomic, copy) NSString *imageURL;



- (instancetype)initWithAttributes:(NSDictionary *)attributes;

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



@end
