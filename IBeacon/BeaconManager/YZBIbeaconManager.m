//
//  YZBIbeaconManager.m
//  IBeacon
//
//  Created by MacBook on 14-6-4.
//  Copyright (c) 2014年 YZB. All rights reserved.
//

#import "YZBIbeaconManager.h"

@implementation YZBIbeaconManager

static YZBIbeaconManager *yzbManager = nil;
+ (YZBIbeaconManager *)shareBeaconManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        yzbManager = [[YZBIbeaconManager alloc] init];
    });
    return yzbManager;
    
}


- (void)searchBeaconSuccess:(void (^)(NSArray *arr))success
                    failure:(void (^)(NSError *error))failure
{
    
    

}








@end
