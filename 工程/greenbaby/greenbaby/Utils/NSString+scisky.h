//
//  NSString+scisky.h
//  scisky
//
//  Created by 刘向宏 on 15/6/18.
//  Copyright © 2015年 刘向宏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define kErrorEmpty @"服务器返回错误"
#define kErrorConnect @"无法连接到服务器"
#define baseURL @"http://112.74.28.104:8090/greenbaby"
#define resourceSeeURL @"http://112.74.28.104/ResourceServer/"

@interface NSString (scisky)
-(NSString *)AESEncrypt;
- (BOOL)checkTel;
+ (BOOL)validateIDCardNumber:(NSString *)value;
- (BOOL)isValidateEmail;
- (NSString *)toResourceSeeURL;
@end

