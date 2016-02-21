//
//  DeviceRequest.m
//  greenbaby
//
//  Created by 刘向宏 on 16/2/21.
//  Copyright © 2016年 刘向宏. All rights reserved.
//

#import "DeviceRequest.h"
#import "BaseHTTPRequestOperationManager.h"

#define kMethodGetHomePageScore @"/score/getHomePageScore"
#define kMethodGetRanking @"/score/getRanking"


@implementation DeviceRequest
+ (void)GetHomePageScoreWithParameters: (id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    [[BaseHTTPRequestOperationManager sharedManager]defaultHTTPWithMethod:kMethodGetHomePageScore WithParameters:parameters post:YES success:success failure:failure];
}

+ (void)GetRankingWithParameters: (id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    [[BaseHTTPRequestOperationManager sharedManager]defaultHTTPWithMethod:kMethodGetRanking WithParameters:parameters post:YES success:success failure:failure];
}
@end
