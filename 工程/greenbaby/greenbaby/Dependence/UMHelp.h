//
//  UMHelp.h
//  greenbaby
//
//  Created by 刘向宏 on 15/12/11.
//  Copyright © 2015年 刘向宏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UMSocialWechatHandler.h"
#import "UMSocial.h"

@interface UMHelp : NSObject
+(void)loginUMSocialSnsPlatform:(UMSocialSnsPlatform *)snsPlatform vc:(UIViewController *)presentingController server:(UMSocialControllerService *)socialControllerService isPresent:(BOOL)isPresentInController completion:(void (^)(UMSocialResponseEntity * response))completion;

+(void)postSNSWithTypes:(NSArray *)platformTypes content:(NSString *)content image:(id)image presentedController:(UIViewController *)presentedController completion:(void (^)(UMSocialResponseEntity * response))completion;
@end
