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
#define kMethodGetCandlestickCharts @"/score/getCandlestickCharts"
#define kMethodGetEyeDiaries @"/eyediary/getEyeDiaries"
#define kMethodRemoteCapture @"/device/remoteCapture"
#define kMethodGetDeviceIp @"/device/getDeviceIp"


@implementation DeviceRequest
+ (void)GetHomePageScoreWithParameters: (id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    [[BaseHTTPRequestOperationManager sharedManager]defaultHTTPWithMethod:kMethodGetHomePageScore WithParameters:parameters post:YES success:success failure:failure];
}

+ (void)GetRankingWithParameters: (id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    [[BaseHTTPRequestOperationManager sharedManager]defaultHTTPWithMethod:kMethodGetRanking WithParameters:parameters post:YES success:success failure:failure];
}

+ (void)GetCandlestickChartsWithParameters: (id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    [[BaseHTTPRequestOperationManager sharedManager]defaultHTTPWithMethod:kMethodGetCandlestickCharts WithParameters:parameters post:YES success:success failure:failure];
}

+ (void)GetEyeDiariesWithParameters: (id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    [[BaseHTTPRequestOperationManager sharedManager]defaultHTTPWithMethod:kMethodGetEyeDiaries WithParameters:parameters post:YES success:success failure:failure];
}

+ (void)RemoteCaptureWithParameters: (id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    [[BaseHTTPRequestOperationManager sharedManager]defaultHTTPWithMethod:kMethodRemoteCapture WithParameters:parameters post:YES success:success failure:failure];
}

+ (void)GetDeviceIpWithParameters: (id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    [[BaseHTTPRequestOperationManager sharedManager]defaultHTTPWithMethod:kMethodGetDeviceIp WithParameters:parameters post:YES success:success failure:failure];
}

+(void)GetImage:(NSString *)url success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    [[BaseHTTPRequestOperationManager sharedManager] GetImage:url success:success failure:failure];
}

+(NSData *)beginData{
    char dd[2] = {0xFF, 0xD8};
    return [NSData dataWithBytes:dd length:2];
}

+(NSData *)endData{
    char dd[2] = {0xFF, 0xD9};
    return [NSData dataWithBytes:dd length:2];
}
@end
