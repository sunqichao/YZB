//
//  UserModel.h
//  IBeacon
//
//  Created by MacBook on 14-6-17.
//  Copyright (c) 2014年 YZB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

+ (void)getCheckNumberWithPhone:(NSString *)phone
                          block:(void(^)(NSArray *data,NSError *error))block;


+ (void)signUpWithPhoneNumber:(NSString *)phone
                     password:(NSString *)psd
                        block:(void(^)(NSArray *data,NSError *error))block;

+ (void)loginWithUserName:(NSString *)name
                 password:(NSString *)psd
                    block:(void(^)(NSArray *data,NSError *error))block;

@end
