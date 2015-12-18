//
//  FileRequest.m
//  Where'sBaby
//
//  Created by 刘向宏 on 15/10/15.
//  Copyright © 2015年 coolLH. All rights reserved.
//

#import "FileRequest.h"
#import "BaseHTTPRequestOperationManager.h"
#define uploadResourceURL @"http://120.25.159.193/ResourceServer/image"

@implementation FileRequest

+(void)UploadImage:(UIImage *)image success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    [[BaseHTTPRequestOperationManager sharedManager] filePostWithUrl:uploadResourceURL WithParameters:UIImageJPEGRepresentation(image, 0.8) success:success failure:failure];
}
@end
