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
@end
