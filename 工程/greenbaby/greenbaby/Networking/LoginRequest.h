//
//  LoginRequest.h
//  Where'sBaby
//
//  Created by 刘向宏 on 15/9/14.
//  Copyright © 2015年 coolLH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginRequest : NSObject

+ (void)GetAuthCodeWithParameters: (id)parameters type:(int)type success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+ (void)UserLoginWithParameters: (id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+ (void)BindmobileWithParameters: (id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+ (void)GetConfigWithParameters: (id)parameters type:(NSInteger)type success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+ (void)UpdateEndUserWithParameters: (id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
@end
