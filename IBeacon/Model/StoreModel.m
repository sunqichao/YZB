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
    self.sid = attributes[@"ibeaconId"]?attributes[@"ibeaconId"]:@"";
    self.title = attributes[@"messTitle"]?attributes[@"messTitle"]:@"";
    self.subtitle = attributes[@"messWord"]?attributes[@"messWord"]:@"";
    self.content = attributes[@"messWord"]?attributes[@"messWord"]:@"";
    self.contentURL = attributes[@"ibeaconUrl"]?attributes[@"ibeaconUrl"]:@"";
    self.imageURL = [self getRightImageURL:[NSString stringWithFormat:@"%@",attributes[@"imgId"]?attributes[@"imgId"]:@""]];
    
    return self;
}

- (void)setNumbers:(NSDictionary *)dic
{
    self.APPROVESUM = [NSString stringWithFormat:@"%@",dic[@"APPROVESUM"]];
    self.ISCOLLECT = [NSString stringWithFormat:@"%@",dic[@"ISCOLLECT"]];
    self.COMMENTSUM = [NSString stringWithFormat:@"%@",dic[@"COMMENTSUM"]];
    self.ISAPPROVE = [NSString stringWithFormat:@"%@",dic[@"ISAPPROVE"]];
    self.SHARESUM = [NSString stringWithFormat:@"%@",dic[@"SHARESUM"]];
    self.COLLECTSUM = [NSString stringWithFormat:@"%@",dic[@"COLLECTSUM"]];


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

- (void)getCommentArrayWithPage:(int)page block:(void(^)(NSArray *data,NSError *error))block
{
    NSString *method = @"selectIbeaconCommentList";
    NSString *appKey = @"13";
    NSString *serviceName = @"prodIbeaconOperateInfoApiService";
    NSString *version = @"1.0";
    NSString *messId = @"3";
    int pageIndex = page;
    NSString *pageSize = @"20";
    //    NSString *ibeaconId = self.sid;
    NSString *sign = [YZBAPIHelper getSignWithKey:appKey];
    
    NSString *path = [NSString stringWithFormat:@"elocal/api?sign=%@&method=%@&appKey=%@&serviceName=%@&version=%@&messId=%@&pageSize=%@&pageIndex=%d",sign,method,appKey,serviceName,version,messId,pageSize,pageIndex];
    
    
    [[YZBAPI shareYZBAPI] POST:path parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        
        NSDictionary *postsFromResponse = (NSDictionary *)JSON;
        id result = postsFromResponse[@"simpleObject"];
        if ([result isKindOfClass:[NSDictionary class]]) {
            block([NSDictionary dictionaryWithDictionary:result], nil);
            
        }
        
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block([NSDictionary dictionary], error);
        }
    }];

}

- (void)getZanMessageInformationWithBlock:(void(^)(NSDictionary *data,NSError *error))block;
{
    NSString *method = @"getCountOperateTotal";
    NSString *appKey = @"13";
    NSString *serviceName = @"prodIbeaconOperateInfoApiService";
    NSString *version = @"1.0";
    NSString *phone = @"18516008978";
    NSString *messId = @"3";
//    NSString *ibeaconId = self.sid;
    NSString *sign = [YZBAPIHelper getSignWithKey:appKey];
    
    NSString *path = [NSString stringWithFormat:@"elocal/api?sign=%@&method=%@&appKey=%@&serviceName=%@&version=%@&messId=%@&phone=%@",sign,method,appKey,serviceName,version,messId,phone];
    
    
    [[YZBAPI shareYZBAPI] POST:path parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        
        NSDictionary *postsFromResponse = (NSDictionary *)JSON;
        id result = postsFromResponse[@"simpleObject"];
        if ([result isKindOfClass:[NSDictionary class]]) {
            block([NSDictionary dictionaryWithDictionary:result], nil);

        }
        
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block([NSDictionary dictionary], error);
        }
    }];

    
}

- (void)setZanMessageInformationWithType:(NSString *)type commentWord:(NSString *)comment block:(void(^)(NSDictionary *data,NSError *error))block
{
    NSString *method = @"addProdIbeaconOperateInfo";
    NSString *appKey = @"13";
    NSString *serviceName = @"prodIbeaconOperateInfoApiService";
    NSString *version = @"1.0";
    NSString *phone = @"18516008978";
    NSString *messId = @"3";
    NSString *operateType = type;
    NSString *commentWord = comment;
    //    NSString *ibeaconId = self.sid;
    NSString *sign = [YZBAPIHelper getSignWithKey:appKey];
    
    NSString *path = [NSString stringWithFormat:@"elocal/api?sign=%@&method=%@&appKey=%@&serviceName=%@&version=%@&messId=%@&phone=%@&operateType=%@&commentWord=%@",sign,method,appKey,serviceName,version,messId,phone,operateType,commentWord];
    
    
    [[YZBAPI shareYZBAPI] POST:path parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        
        NSDictionary *postsFromResponse = (NSDictionary *)JSON;
        id result = postsFromResponse[@"simpleObject"];
        block(result, nil);

        
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block([NSDictionary dictionary], error);
        }
    }];
    
    
}


- (void)cancelZanWithBlock:(void(^)(NSDictionary *data,NSError *error))block
{
    NSString *method = @"cancelProdIbeaconOperateInfo";
    NSString *appKey = @"13";
    NSString *serviceName = @"prodIbeaconOperateInfoApiService";
    NSString *version = @"1.0";
    NSString *phone = @"18516008978";
    NSString *messId = @"3";
    NSString *operateType = @"1";
    NSString *commentWord = @"";
    //    NSString *ibeaconId = self.sid;
    NSString *sign = [YZBAPIHelper getSignWithKey:appKey];
    
    NSString *path = [NSString stringWithFormat:@"elocal/api?sign=%@&method=%@&appKey=%@&serviceName=%@&version=%@&messId=%@&phone=%@&operateType=%@&commentWord=%@",sign,method,appKey,serviceName,version,messId,phone,operateType,commentWord];
    
    
    [[YZBAPI shareYZBAPI] POST:path parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        
        NSDictionary *postsFromResponse = (NSDictionary *)JSON;
        id result = postsFromResponse[@"simpleObject"];
        block(result,nil);
        
        
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        block(nil,error);

        
    }];

}


- (void)cancelCollectionWithBlock:(void(^)(NSDictionary *data,NSError *error))block
{
    NSString *method = @"cancelProdIbeaconOperateInfo";
    NSString *appKey = @"13";
    NSString *serviceName = @"prodIbeaconOperateInfoApiService";
    NSString *version = @"1.0";
    NSString *phone = @"18516008978";
    NSString *messId = @"3";
    NSString *operateType = @"2";
    NSString *commentWord = @"";
    //    NSString *ibeaconId = self.sid;
    NSString *sign = [YZBAPIHelper getSignWithKey:appKey];
    
    NSString *path = [NSString stringWithFormat:@"elocal/api?sign=%@&method=%@&appKey=%@&serviceName=%@&version=%@&messId=%@&phone=%@&operateType=%@&commentWord=%@",sign,method,appKey,serviceName,version,messId,phone,operateType,commentWord];
    
    
    [[YZBAPI shareYZBAPI] POST:path parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        
        NSDictionary *postsFromResponse = (NSDictionary *)JSON;
        id result = postsFromResponse[@"simpleObject"];
        block(result,nil);

        
        
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        block(nil,error);

        
    }];
}








@end
