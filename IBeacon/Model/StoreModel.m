//
//  StoreModel.m
//  IBeacon
//
//  Created by MacBook on 14-6-4.
//  Copyright (c) 2014年 YZB. All rights reserved.
//

#import "StoreModel.h"
#import "YZBAPI.h"
#import "YZBAPIHelper.h"
@implementation StoreModel


- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.title = [attributes valueForKeyPath:@"title"];
    self.subtitle = [attributes valueForKeyPath:@"subtitle"];
    self.content = [attributes valueForKeyPath:@"content"];
    
    return self;
}


+ (void)getStoreInformationWithId:(id)sid block:(void(^)(NSArray *data,NSError *error))block
{
    NSString *sign = [YZBAPIHelper getSign];
    NSString *method = @"getProdIbeacon";
    NSString *appKey = @"01";
    NSString *serviceName = @"prodIbeaconApiService";
    NSString *version = @"1.0";
    NSString *ibeaconId = sid;
    
    NSDictionary *param = @{@"sign":sign,
                            @"method":method,
                            @"appKey":appKey,
                            @"serviceName":serviceName,
                            @"version":version,
                            @"ibeaconId":ibeaconId
                            };
    
    [[YZBAPI shareYZBAPI] GET:@"elocal-api/api" parameters:param success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSArray *postsFromResponse = (NSArray *)JSON;
        NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:[postsFromResponse count]];
        for (NSDictionary *attributes in postsFromResponse) {
            StoreModel *store = [[StoreModel alloc] initWithAttributes:attributes];
            [mutablePosts addObject:store];
        }
        
        if (block) {
            block([NSArray arrayWithArray:mutablePosts], nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block([NSArray array], error);
        }
    }];
    
}



@end
