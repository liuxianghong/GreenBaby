//
//  UMHelp.m
//  greenbaby
//
//  Created by 刘向宏 on 15/12/11.
//  Copyright © 2015年 刘向宏. All rights reserved.
//

#import "UMHelp.h"

@implementation UMHelp
+(void)loginUMSocialSnsPlatform:(UMSocialSnsPlatform *)snsPlatform vc:(UIViewController *)presentingController server:(UMSocialControllerService *)socialControllerService isPresent:(BOOL)isPresentInController completion:(void (^)(UMSocialResponseEntity * response))completion{
    snsPlatform.loginClickHandler(presentingController,socialControllerService,isPresentInController,^(UMSocialResponseEntity *response){
        
        completion(response);
        
    });
}


+(void)postSNSWithTypes:(NSArray *)platformTypes content:(NSString *)content image:(id)image presentedController:(UIViewController *)presentedController completion:(void (^)(UMSocialResponseEntity * response))completion{
    //使用UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite分别代表微信好友、微信朋友圈、微信收藏
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeImage;
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:platformTypes content:content image:image location:nil urlResource:nil presentedController:presentedController completion:completion];
}
@end
