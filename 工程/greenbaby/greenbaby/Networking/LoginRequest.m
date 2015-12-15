//
//  LoginRequest.m
//  Where'sBaby
//
//  Created by 刘向宏 on 15/9/14.
//  Copyright © 2015年 coolLH. All rights reserved.
//

#import "BaseHTTPRequestOperationManager.h"
#import "LoginRequest.h"


#define kMethodUserGetAuthCode @"/sms/vcode"
#define kMethodUserLogin @"/enduser/login"
#define kMethodBindmobile @"/enduser/bindmobile"

#define kMethodConfigEyesight @"/config/eyesight"
#define kMethodConfigReadingtime @"/config/readingtime"
#define kMethodConfigAge @"/config/age"
#define kMethodConfigCity @"/config/city/"
#define kMethodConfigProvince @"/config/province"

#define kMethodUpdateEndUser @"/enduser/updateEndUser"

@implementation LoginRequest

+ (void)GetAuthCodeWithParameters: (id)parameters type:(int)type  success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    [[BaseHTTPRequestOperationManager sharedManager]defaultHTTPWithMethod:kMethodUserGetAuthCode WithParameters:parameters post:YES success:success failure:failure];
//    if (type==0) {
//        
//    }
//    else
//    {
//        [[BaseHTTPRequestOperationManager sharedManager]defaultHTTPWithMethod:kMethodForgetPassword WithParameters:parameters post:YES success:success failure:failure];
//    }
}

+ (void)UserLoginWithParameters: (id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    [[BaseHTTPRequestOperationManager sharedManager]defaultHTTPWithMethod:kMethodUserLogin WithParameters:parameters post:YES success:success failure:failure];
}

+ (void)BindmobileWithParameters: (id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    [[BaseHTTPRequestOperationManager sharedManager]defaultHTTPWithMethod:kMethodBindmobile WithParameters:parameters post:YES success:success failure:failure];
}

+ (void)GetConfigWithParameters: (id)parameters type:(NSInteger)type success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"";
    switch (type) {
        case 0:
            url = kMethodConfigEyesight;
            break;
        case 1:
            url = kMethodConfigReadingtime;
            break;
        case 2:
            url = kMethodConfigAge;
            break;
        case 3:
            url = kMethodConfigProvince;
            break;
        case 4:
            url = [NSString stringWithFormat:@"%@%@",kMethodConfigCity,parameters];
            break;
            
        default:
            break;
    }
    
    [[BaseHTTPRequestOperationManager sharedManager]defaultHTTPWithMethod:url WithParameters:nil post:YES success:success failure:failure];
}


+ (void)UpdateEndUserWithParameters: (id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    [[BaseHTTPRequestOperationManager sharedManager]defaultHTTPWithMethod:kMethodUpdateEndUser WithParameters:parameters post:YES success:success failure:failure];
}

@end
