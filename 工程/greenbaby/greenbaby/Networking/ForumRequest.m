//
//  ForumRequest.m
//  greenbaby
//
//  Created by 刘向宏 on 15/12/17.
//  Copyright © 2015年 刘向宏. All rights reserved.
//

#import "ForumRequest.h"
#import "BaseHTTPRequestOperationManager.h"

#define kMethodGetForumGroup @"/forum/getForumGroup"
#define kMethodGetForumThreadsInGroup @"/forum/getForumThreadsInGroup"
#define kMethodGetForumThreadsDetail @"/forum/getForumThreadDetail"
#define kMethodUpdateForumComment @"/forum/updateForumComment"
#define kMethodUpdateForumPraise @"/forum/updateForumPraise"
#define kMethodPostForumThread @"/forum/postForumThread"
#define kMethodGetSelfPostForumThread @"/forum/getSelfPostForumThread"
#define kMethodGetSelfReplyForumThread @"/forum/getSelfReplyForumThread"

@implementation ForumRequest
+ (void)GetForumGroupWithParameters: (id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    [[BaseHTTPRequestOperationManager sharedManager]defaultHTTPWithMethod:kMethodGetForumGroup WithParameters:parameters post:YES success:success failure:failure];
}

+ (void)GetForumThreadsInGroupWithParameters: (id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    [[BaseHTTPRequestOperationManager sharedManager]defaultHTTPWithMethod:kMethodGetForumThreadsInGroup WithParameters:parameters post:YES success:success failure:failure];
}


+ (void)GetForumThreadsDetailWithParameters: (id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    [[BaseHTTPRequestOperationManager sharedManager]defaultHTTPWithMethod:kMethodGetForumThreadsDetail WithParameters:parameters post:YES success:success failure:failure];
}

+ (void)UpdateForumCommentWithParameters: (id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    [[BaseHTTPRequestOperationManager sharedManager]defaultHTTPWithMethod:kMethodUpdateForumComment WithParameters:parameters post:YES success:success failure:failure];
}

+ (void)UpdateForumPraiseWithParameters: (id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    [[BaseHTTPRequestOperationManager sharedManager]defaultHTTPWithMethod:kMethodUpdateForumPraise WithParameters:parameters post:YES success:success failure:failure];
}

+ (void)PostForumThreadWithParameters: (id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    [[BaseHTTPRequestOperationManager sharedManager]defaultHTTPWithMethod:kMethodPostForumThread WithParameters:parameters post:YES success:success failure:failure];
}

+ (void)GetMyThreadWithParameters: (id)parameters post:(BOOL)post success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    NSString *method = post ? kMethodGetSelfPostForumThread : kMethodGetSelfReplyForumThread;
    [[BaseHTTPRequestOperationManager sharedManager]defaultHTTPWithMethod:method WithParameters:parameters post:YES success:success failure:failure];
}



@end
