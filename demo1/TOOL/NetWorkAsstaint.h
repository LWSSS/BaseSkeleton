//
//  NetWorkAsstaint.h
//  demo1
//
//  Created by liuwei on 2018/3/7.
//  Copyright © 2018年 liuwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

typedef NS_ENUM(NSInteger, RequestMethod) {
    GET,
    POST,
};

@interface NetWorkAsstaint : AFHTTPSessionManager

+(instancetype)sharedAssistaint;

-(void)requestDataByMethod:(RequestMethod)requestMethod url:(NSString *)url params:(NSDictionary *)params hud:(NSString *)hud finishBlock: (void(^)(id responseObject,NSError * error))finishBlock;


-(void)requestNetWithMethod:(RequestMethod)requestMesthod url:(NSString *)url params:(NSDictionary *)params hud:(NSString *)hud
                finishBlock:(void(^)(id responseobject, NSError * error))finishBlock;
@end
