//
//  YZBAPI.h
//  IBeacon
//
//  Created by MacBook on 14-6-4.
//  Copyright (c) 2014年 YZB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@interface YZBAPI : AFHTTPSessionManager

+ (YZBAPI *)shareYZBAPI;




@end
