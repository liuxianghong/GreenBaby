//
//  ForumRequest.h
//  greenbaby
//
//  Created by 刘向宏 on 15/12/17.
//  Copyright © 2015年 刘向宏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ForumRequest : NSObject
+ (void)GetForumGroupWithParameters: (id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+ (void)GetForumThreadsInGroupWithParameters: (id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+ (void)GetForumThreadsInGroupPageWithParameters: (id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+ (void)GetForumThreadsDetailWithParameters: (id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+ (void)UpdateForumCommentWithParameters: (id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+ (void)UpdateForumPraiseWithParameters: (id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+ (void)PostForumThreadWithParameters: (id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+ (void)GetMyThreadWithParameters: (id)parameters post:(BOOL)post success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+ (void)GetMyThreadPageWithParameters: (id)parameters post:(BOOL)post success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
@end
