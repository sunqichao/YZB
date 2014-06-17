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
    self.sid = [attributes valueForKey:@"id"]?[attributes valueForKey:@"id"]:@"";
    self.title = [attributes valueForKey:@"messTitle"]?[attributes valueForKey:@"messTitle"]:@"";
    self.subtitle = [attributes valueForKey:@"messWord"]?[attributes valueForKey:@"messWord"]:@"";
    self.contentURL = [attributes valueForKey:@"ibeaconUrl"]?[attributes valueForKey:@"ibeaconUrl"]:@"";
    self.imageURL = [self getRightImageURL:[NSString stringWithFormat:@"%@",[attributes valueForKey:@"imgId"]?[attributes valueForKey:@"imgId"]:@""]];
    
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



+ (BOOL)isSameHistoryData:(id)data
{
    __block BOOL isSame = NO;
    StoreModel *target = (StoreModel *)data;
    NSArray *history = [SingleDataManager shareSingleDataManager].historyArray;
    if (!history||history.count==0) {
        return NO;
    }
    [history enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        StoreModel *hisData = (StoreModel *)obj;
        if ([hisData.sid isEqual:target.sid]) {
            isSame = YES;
        }
        
    }];
    
    
    return isSame;
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
        id result = postsFromResponse[@"simpleObject"];
        if ([result isKindOfClass:[NSDictionary class]]) {
            StoreModel *store = [[StoreModel alloc] initWithAttributes:postsFromResponse[@"simpleObject"]];
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
