//
//  SingleDataManager.h
//  IBeacon
//
//  Created by MacBook on 14-6-12.
//  Copyright (c) 2014年 YZB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleDataManager : NSObject


@property (retain, nonatomic) NSArray *historyArray;



+ (SingleDataManager *)shareSingleDataManager;




@end
