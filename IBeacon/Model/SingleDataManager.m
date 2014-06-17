//
//  SingleDataManager.m
//  IBeacon
//
//  Created by MacBook on 14-6-12.
//  Copyright (c) 2014年 YZB. All rights reserved.
//

#import "SingleDataManager.h"

@implementation SingleDataManager

static SingleDataManager *single = nil;
+ (SingleDataManager *)shareSingleDataManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        single = [[SingleDataManager alloc] init];
    });
    return single;
}









@end
