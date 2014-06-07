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
    NSString *method = @"getProdIbeacon";
    NSString *appKey = @"13";
    NSString *serviceName = @"prodIbeaconApiService";
    NSString *version = @"1.0";
    NSString *ibeaconId = sid;
    NSString *sign = [YZBAPIHelper getSignWithKey:appKey];

    NSDictionary *param = @{@"sign":sign,
                            @"method":method,
                            @"appKey":appKey,
                            @"serviceName":serviceName,
                            @"version":version,
                            @"ibeaconId":ibeaconId
                            };
    
    NSString *path = [NSString stringWithFormat:@"elocal/api?sign=%@&method=%@&appKey=%@&serviceName=%@&version=%@&ibeaconId=%@",sign,method,appKey,serviceName,version,ibeaconId];
    

    [[YZBAPI shareYZBAPI] POST:path parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSArray *postsFromResponse = (NSArray *)JSON;
        return ;
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
