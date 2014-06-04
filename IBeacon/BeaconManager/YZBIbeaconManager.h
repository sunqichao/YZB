//
//  YZBIbeaconManager.h
//  IBeacon
//
//  Created by MacBook on 14-6-4.
//  Copyright (c) 2014年 YZB. All rights reserved.
//

#import <Foundation/Foundation.h>

//uuid FFE1
#define TestUUID @"471F5178-9A47-1010-A2B9-9FFA80A3C02C"
#define TestMajor @"1000"
#define TestMinor @""



@interface YZBIbeaconManager : NSObject

+ (YZBIbeaconManager *)shareBeaconManager;

- (void)searchBeaconSuccess:(void (^)(NSArray *arr))success
                    failure:(void (^)(NSError *error))failure;

@end
