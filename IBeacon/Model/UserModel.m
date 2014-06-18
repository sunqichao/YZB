//
//  UserModel.m
//  IBeacon
//
//  Created by MacBook on 14-6-17.
//  Copyright (c) 2014年 YZB. All rights reserved.
//

#import "UserModel.h"
#import "YZBAPIHelper.h"
#import "YZBAPI.h"

@implementation UserModel

+ (void)getCheckNumberWithPhone:(NSString *)phone
                          block:(void(^)(NSArray *data,NSError *error))block
{
    NSString *method = @"sendCaptcha";
    NSString *appKey = @"13";
    NSString *serviceName = @"prodUserInfoApiService";
    NSString *version = @"1.0";
    NSString *loginName = phone;
    NSString *sign = [YZBAPIHelper getSignWithKey:appKey];
    
    NSString *path = [NSString stringWithFormat:@"elocal/api?sign=%@&method=%@&appKey=%@&serviceName=%@&version=%@&phone=%@",sign,method,appKey,serviceName,version,loginName];
    
    [[YZBAPI shareYZBAPI] POST:path parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        
        NSDictionary *postsFromResponse = (NSDictionary *)JSON;
        
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block([NSArray array], error);
        }
    }];


}


+ (void)signUpWithPhoneNumber:(NSString *)phone
                      checkMa:(NSString *)checkMa
                     password:(NSString *)psd
                        block:(void(^)(NSArray *data,NSError *error))block

{
    NSString *method = @"prodUserLogin";
    NSString *appKey = @"13";
    NSString *serviceName = @"prodUserInfoApiService";
    NSString *version = @"1.0";
    NSString *loginName = phone;
    NSString *clientVersion = @"1.0";
    NSString *loginPwd = psd;
    NSString *checkMobileId = checkMa;
    NSString *sign = [YZBAPIHelper getSignWithKey:appKey];
    
    NSString *path = [NSString stringWithFormat:@"elocal/api?sign=%@&method=%@&appKey=%@&serviceName=%@&version=%@&phone=%@&loginPwd=%@&clientVersion=%@&checkMobileId=%@",sign,method,appKey,serviceName,version,loginName,loginPwd,clientVersion,checkMa];
    
    [[YZBAPI shareYZBAPI] POST:path parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        
        NSDictionary *postsFromResponse = (NSDictionary *)JSON;
        
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block([NSArray array], error);
        }
    }];
    

    

}

+ (void)loginWithUserName:(NSString *)name
                 password:(NSString *)psd
                    block:(void(^)(NSArray *data,NSError *error))block
{



}



@end
