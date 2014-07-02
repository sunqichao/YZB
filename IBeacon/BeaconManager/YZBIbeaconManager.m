//
//  YZBIbeaconManager.m
//  IBeacon
//
//  Created by MacBook on 14-6-4.
//  Copyright (c) 2014年 YZB. All rights reserved.
//

#import "YZBIbeaconManager.h"

static NSString * const kUUID = @"74278BDA-B644-4520-8F0C-720EAF059935";
static NSString * const kIdentifier = @"SomeIdentifier";

static void * const kMonitoringOperationContext = (void *)&kMonitoringOperationContext;
static void * const kRangingOperationContext = (void *)&kRangingOperationContext;


@interface YZBIbeaconManager()<CLLocationManagerDelegate, CBPeripheralManagerDelegate>

@property (nonatomic, strong) CLBeaconRegion *beaconRegion;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CBPeripheralManager *peripheralManager;

/**
 *  检测到的beacon数组
 */
@property (nonatomic, strong) NSArray *detectedBeacons;

/**
 *  当前的检测到beacon的数量，用来判断是否跟detectedBeacons的数量一样，一样就不更新界面，不一样在更新界面
 */
@property (nonatomic, assign) NSInteger currentBeaconNumber;

/**
 *  当前操作的上下文
 */
@property (nonatomic, unsafe_unretained) void *operationContext;


@property (strong, nonatomic) NSArray *UUIDArray;


@end

@implementation YZBIbeaconManager


- (NSArray *)UUIDArray
{
    NSArray *results = @[@"74278BDA-B644-4520-8F0C-720EAF059935",
                         @"E2C56DB5-DFFB-48D2-B060-D0F5A71096E0"];

    return results;
}



static YZBIbeaconManager *yzbManager = nil;
+ (YZBIbeaconManager *)shareBeaconManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        yzbManager = [[YZBIbeaconManager alloc] init];
    });
    return yzbManager;
    
}

#pragma mark - create beaconRegion and location

- (void)createBeaconRegion
{
    if (self.beaconRegion)
        return;
    
    NSUUID *proximityUUID = [[NSUUID alloc] initWithUUIDString:kUUID];
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:proximityUUID identifier:kIdentifier];
    self.beaconRegion.notifyEntryStateOnDisplay = YES;
}

- (void)createLocationManager
{
    if (!self.locationManager) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
    }
}

#pragma mark - 过滤 beacon

- (NSArray *)filteredBeacons:(NSArray *)beacons
{
    // Filters duplicate beacons out; this may happen temporarily if the originating device changes its Bluetooth id
    NSMutableArray *mutableBeacons = [beacons mutableCopy];
    
    NSMutableSet *lookup = [[NSMutableSet alloc] init];
    for (int index = 0; index < [beacons count]; index++) {
        CLBeacon *curr = [beacons objectAtIndex:index];
        NSString *identifier = [NSString stringWithFormat:@"%@/%@", curr.major, curr.minor];
        
        // this is very fast constant time lookup in a hash table
        if ([lookup containsObject:identifier]) {
            [mutableBeacons removeObjectAtIndex:index];
        } else {
            [lookup addObject:identifier];
        }
    }
    
    return [mutableBeacons copy];
}


#pragma mark - 启动beacon监视器，用来检测是否进入beacon区域（7.1以上系统可以在关闭应用的情况下收到通知）
 
- (void)startMonitoringForBeacons
{
    [self createLocationManager];
    
    self.operationContext = kMonitoringOperationContext;

    [self turnOnMonitoring];

}


- (void)turnOnMonitoring
{
    NSLog(@"Turning on monitoring...");
    
    if (![CLLocationManager isMonitoringAvailableForClass:[CLBeaconRegion class]]) {
        NSLog(@"Couldn't turn on region monitoring: Region monitoring is not available for CLBeaconRegion class.");
        
        return;
    }
    
    [self createBeaconRegion];
    [self.locationManager startMonitoringForRegion:self.beaconRegion];
    
    NSLog(@"Monitoring turned on for region: %@.", self.beaconRegion);
}


#pragma mark - 停止监视器
 
- (void)stopMonitoringForBeacons
{
    [self.locationManager stopMonitoringForRegion:self.beaconRegion];
    
    NSLog(@"Turned off monitoring");

}

#pragma mark -   开始搜索并排列出beacon
 
- (void)startRangingForBeacons
{
    [self createLocationManager];
    self.operationContext = kRangingOperationContext;
    self.detectedBeacons = [NSArray array];
    [self turnOnRanging];

}

- (void)turnOnRanging
{
    NSLog(@"Turning on ranging...");
    
    if (![CLLocationManager isRangingAvailable]) {
        NSLog(@"Couldn't turn on ranging: Ranging is not available.");

        return;
    }
    
    if (self.locationManager.rangedRegions.count > 0) {
        NSLog(@"Didn't turn on ranging: Ranging already on.");
        return;
    }
    
    [self createBeaconRegion];
    [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
    
    NSLog(@"Ranging turned on for region: %@.", self.beaconRegion);
}


#pragma mark -   停止排列
 
- (void)stopRangingForBeacons
{
    if (self.locationManager.rangedRegions.count == 0) {
        NSLog(@"Didn't turn off ranging: Ranging already off.");
        return;
    }
    
    [self.locationManager stopRangingBeaconsInRegion:self.beaconRegion];
    

    self.detectedBeacons = [NSArray array];

    
    NSLog(@"Turned off ranging.");

}

#pragma mark - Location manager delegate methods
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (![CLLocationManager locationServicesEnabled]) {
        if (self.operationContext == kMonitoringOperationContext) {
            NSLog(@"Couldn't turn on monitoring: Location services are not enabled.");

            return;
        } else {
            NSLog(@"Couldn't turn on ranging: Location services are not enabled.");

            return;
        }
    }
    
    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorized) {
        if (self.operationContext == kMonitoringOperationContext) {
            NSLog(@"Couldn't turn on monitoring: Location services not authorised.");

            return;
        } else {
            NSLog(@"Couldn't turn on ranging: Location services not authorised.");

            return;
        }
    }
    
    if (self.operationContext == kMonitoringOperationContext) {

    } else {

    }
}

- (void)locationManager:(CLLocationManager *)manager
        didRangeBeacons:(NSArray *)beacons
               inRegion:(CLBeaconRegion *)region {
    NSArray *filteredBeacons = [self filteredBeacons:beacons];
    
    [filteredBeacons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CLBeacon *curr = (CLBeacon *)obj;
        if ([curr.major isEqualToNumber:[NSNumber numberWithInt:1]]) {
            NSLog(@"%ld",(long)curr.rssi);
        }
        switch (curr.proximity) {
            case CLProximityNear:
//                NSLog(@"near");
                break;
            case CLProximityImmediate:
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"addStartPayInformations" object:nil userInfo:@{@"number":curr.major}];

                break;
            case CLProximityFar:
//                NSLog(@"far");
                break;
            case CLProximityUnknown:
            default:
//                NSLog(@"unknow");
                break;
        }
    }];
    
    if (filteredBeacons.count == 0) {
        NSLog(@"No beacons found nearby.");
    } else {
        NSLog(@"Found %lu %@.", (unsigned long)[filteredBeacons count],
              [filteredBeacons count] > 1 ? @"beacons" : @"beacon");
    }
    /**
     *  如果是蓝牙链接状态再进行，（有延迟的情况）
     */
    if (!self.isDisconnect) {
        self.detectedBeacons = filteredBeacons;
        [self addBeaconMajorID:self.detectedBeacons];
        if (self.currentBeaconNumber) {
            if (self.currentBeaconNumber!=_detectedBeacons.count) {
                self.currentBeaconNumber = self.detectedBeacons.count;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"updateStoreInformations" object:nil userInfo:@{@"number":@(self.currentBeaconNumber)}];
            }
        }else
        {
            self.currentBeaconNumber = _detectedBeacons.count;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"updateStoreInformations" object:nil userInfo:@{@"number":@(self.currentBeaconNumber)}];
            
        }
        
    }
    
    
}

- (void)locationManager:(CLLocationManager *)manager
rangingBeaconsDidFailForRegion:(CLBeaconRegion *)region
              withError:(NSError *)error __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_7_0)
{
    NSLog(@"%@",error);
    
    /**
     *  设置为不可链接状态，上面检测的时候就不会做任何操作了
     */
    self.isDisconnect = YES;
    self.currentBeaconNumber = 0;

    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateStoreInformations" object:nil userInfo:@{@"number":@(0)}];
}

/**
 *  添加主id到majorarray
 *
 *  @param arr 检测到的数据
 */
- (void)addBeaconMajorID:(NSArray *)arr
{
    if (!_majorArray) {
        _majorArray = [[NSMutableArray alloc] init];
    }
    [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CLBeaconRegion *beacon = (CLBeaconRegion *)obj;
        
        if (![self isSameBeacon:beacon.major]) {
            [_majorArray addObject:beacon.major];
        }
    }];

}

- (BOOL)isSameBeacon:(NSNumber *)num
{
    __block BOOL isSame = NO;
    for (int i=0; i<_majorArray.count; i++) {
        NSNumber *beacon = _majorArray[i];
        if (num==beacon) {
            isSame = YES;
        }
    }
    return isSame;
    
}


- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    NSLog(@"Entered region: %@", region);
    
    [self sendLocalNotificationForBeaconRegion:(CLBeaconRegion *)region];
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    NSLog(@"Exited region: %@", region);
}

- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
    NSString *stateString = nil;
    switch (state) {
        case CLRegionStateInside:
            stateString = @"inside";
            break;
        case CLRegionStateOutside:
            stateString = @"outside";
            break;
        case CLRegionStateUnknown:
            stateString = @"unknown";
            break;
    }
    NSLog(@"State changed to %@ for region %@.", stateString, region);
}

#pragma mark - 搜索到ibeacon的本地通知

- (void)sendLocalNotificationForBeaconRegion:(CLBeaconRegion *)region
{
    UILocalNotification *notification = [UILocalNotification new];
    
    // Notification details
    notification.alertBody = [NSString stringWithFormat:@"Entered beacon region for UUID: %@",
                              region.proximityUUID.UUIDString];   // Major and minor are not available at the monitoring stage
    
    notification.alertBody = @"进入小豆子";
    notification.alertAction = NSLocalizedString(@"View Details", nil);
    notification.soundName = UILocalNotificationDefaultSoundName;
    
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}


#pragma mark -   开始广告beacon （用做当基站，暂时用不上这个功能）

- (void)startAdvertisingBeacon
{
    NSLog(@"Turning on advertising...");
    
    [self createBeaconRegion];
    
    if (!self.peripheralManager)
        self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil options:nil];
    
    [self turnOnAdvertising];
    
    
}
- (void)turnOnAdvertising
{
    if (self.peripheralManager.state != CBPeripheralManagerStatePoweredOn) {
        NSLog(@"Peripheral manager is off.");
        
        return;
    }
    
    time_t t;
    srand((unsigned) time(&t));
    CLBeaconRegion *region = [[CLBeaconRegion alloc] initWithProximityUUID:self.beaconRegion.proximityUUID
                                                                     major:rand()
                                                                     minor:rand()
                                                                identifier:self.beaconRegion.identifier];
    NSDictionary *beaconPeripheralData = [region peripheralDataWithMeasuredPower:nil];
    [self.peripheralManager startAdvertising:beaconPeripheralData];
    
    NSLog(@"Turning on advertising for region: %@.", region);
}


#pragma mark -   停止广告beacon

- (void)stopAdvertisingBeacon
{
    [self.peripheralManager stopAdvertising];
    
    NSLog(@"Turned off advertising.");
    
}


#pragma mark - Beacon advertising delegate methods
- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheralManager error:(NSError *)error
{
    if (error) {
        NSLog(@"Couldn't turn on advertising: %@", error);

        return;
    }
    
    if (peripheralManager.isAdvertising) {
        NSLog(@"Turned on advertising.");

    }
}

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheralManager
{
    if (peripheralManager.state != CBPeripheralManagerStatePoweredOn) {
        NSLog(@"Peripheral manager is off.");

        return;
    }
    
    NSLog(@"Peripheral manager is on.");
    [self turnOnAdvertising];
}




- (void)searchBeaconSuccess:(void (^)(NSArray *arr))success
                    failure:(void (^)(NSError *error))failure
{
    
    

}








@end
