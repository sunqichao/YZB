//
//  YZBAPIHelper.m
//  IBeacon
//
//  Created by MacBook on 14-6-5.
//  Copyright (c) 2014年 YZB. All rights reserved.
//

#import "YZBAPIHelper.h"
#import "SQC_StringUtility.h"
@implementation YZBAPIHelper

+ (NSString *)getSignWithKey:(NSString *)appKey
{
    NSString *appkey = @"13";
    NSString *password = @"iBeacon";
    NSString *sign = [NSString stringWithFormat:@"%@&%@",appkey,password];
    NSString *md5Str = [SQC_StringUtility SQCMD5:sign];
    return md5Str;
}


@end
