//
//  BannersRequest.h
//  greenbaby
//
//  Created by 刘向宏 on 15/12/15.
//  Copyright © 2015年 刘向宏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BannersRequest : NSObject

+ (void)GetBannersWithParameters: (id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end
