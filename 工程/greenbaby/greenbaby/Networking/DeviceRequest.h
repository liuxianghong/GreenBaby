//
//  DeviceRequest.h
//  greenbaby
//
//  Created by 刘向宏 on 16/2/21.
//  Copyright © 2016年 刘向宏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceRequest : NSObject
+ (void)GetHomePageScoreWithParameters: (id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+ (void)GetRankingWithParameters: (id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+ (void)GetCandlestickChartsWithParameters: (id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+ (void)GetEyeDiariesWithParameters: (id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+ (void)RemoteCaptureWithParameters: (id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+ (void)GetDeviceIpWithParameters: (id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
@end
