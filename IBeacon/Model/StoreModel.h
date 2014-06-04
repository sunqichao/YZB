//
//  StoreModel.h
//  IBeacon
//
//  Created by MacBook on 14-6-4.
//  Copyright (c) 2014年 YZB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *content;


- (instancetype)initWithAttributes:(NSDictionary *)attributes;


/**
 *  根据id获取商店的信息
 *
 *  @param sid   商店id
 *  @param block 回调
 */
+ (void)getStoreInformationWithId:(id)sid block:(void(^)(NSArray *data,NSError *error))block;



@end
