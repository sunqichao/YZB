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

@import CoreLocation;
@import CoreBluetooth;

@interface YZBIbeaconManager : NSObject

@property (nonatomic, strong) NSMutableArray *majorArray;

+ (YZBIbeaconManager *)shareBeaconManager;


/**
 *  启动beacon监视器，用来检测是否进入beacon区域（7.1以上系统可以在关闭应用的情况下收到通知）
 */
- (void)startMonitoringForBeacons;

/**
 *  停止监视器
 */
- (void)stopMonitoringForBeacons;

/**
 *  开始广告beacon （用做当基站，暂时用不上这个功能）
 */
- (void)startAdvertisingBeacon;

/**
 *  停止广告beacon
 */
- (void)stopAdvertisingBeacon;

/**
 *  开始搜索并排列出beacon
 */
- (void)startRangingForBeacons;

/**
 *  停止排列
 */
- (void)stopRangingForBeacons;




- (void)searchBeaconSuccess:(void (^)(NSArray *arr))success
                    failure:(void (^)(NSError *error))failure;

@end
