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


- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.title = [attributes valueForKey:@"messTitle"];
    self.subtitle = [attributes valueForKey:@"messWord"];
    self.contentURL = [attributes valueForKey:@"ibeaconUrl"];
    self.imageURL = [self getRightImageURL:[NSString stringWithFormat:@"%@",[attributes valueForKey:@"imgId"]]];
    
    return self;
}

- (NSString *)getRightImageURL:(NSString *)imageURL
{
    NSString *method = @"getImageById";
    NSString *appKey = @"13";
    NSString *serviceName = @"imageApiService";
    NSString *version = @"1.0";
    NSString *ibeaconId = imageURL;
    NSString *sign = [YZBAPIHelper getSignWithKey:appKey];
    
    NSString *path = [NSString stringWithFormat:@"http://42.99.16.17:8080/elocal/api?sign=%@&method=%@&appKey=%@&serviceName=%@&version=%@&imgId=%@",sign,method,appKey,serviceName,version,ibeaconId];

    
    return path;
}


+ (void)getStoreInformationWithId:(id)sid block:(void(^)(NSArray *data,NSError *error))block
{
    NSString *method = @"getProdIbeacon";
    NSString *appKey = @"13";
    NSString *serviceName = @"prodIbeaconApiService";
    NSString *version = @"1.0";
    NSString *ibeaconId = sid;
    NSString *sign = [YZBAPIHelper getSignWithKey:appKey];
    
    NSString *path = [NSString stringWithFormat:@"elocal/api?sign=%@&method=%@&appKey=%@&serviceName=%@&version=%@&ibeaconId=%@",sign,method,appKey,serviceName,version,ibeaconId];
    

    [[YZBAPI shareYZBAPI] POST:path parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        
        NSDictionary *postsFromResponse = (NSDictionary *)JSON;
        NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:[postsFromResponse count]];
        StoreModel *store = [[StoreModel alloc] initWithAttributes:postsFromResponse[@"simpleObject"]];
        [mutablePosts addObject:store];
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
