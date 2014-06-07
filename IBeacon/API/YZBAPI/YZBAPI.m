//
//  YZBAPI.m
//  IBeacon
//
//  Created by MacBook on 14-6-4.
//  Copyright (c) 2014年 YZB. All rights reserved.
//

#import "YZBAPI.h"
#import "AFNetworking.h"

@interface YZBAPI ()

@end

static NSString * const AFAppDotNetAPIBaseURLString = @"http://42.99.16.17:8080/";
//static NSString * const AFAppDotNetAPIBaseURLString = @"http://192.168.38.53:8080/";

@implementation YZBAPI

+ (instancetype)shareYZBAPI {
    static YZBAPI *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[YZBAPI alloc] initWithBaseURL:[NSURL URLWithString:AFAppDotNetAPIBaseURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return _sharedClient;
}




@end
