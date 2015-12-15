//
//  BannersRequest.m
//  greenbaby
//
//  Created by 刘向宏 on 15/12/15.
//  Copyright © 2015年 刘向宏. All rights reserved.
//

#import "BannersRequest.h"
#import "BaseHTTPRequestOperationManager.h"

#define kMethodGetBanners @"/info/banners"

@implementation BannersRequest

+ (void)GetBannersWithParameters: (id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    [[BaseHTTPRequestOperationManager sharedManager]defaultHTTPWithMethod:kMethodGetBanners WithParameters:parameters post:YES success:success failure:failure];
}

@end
