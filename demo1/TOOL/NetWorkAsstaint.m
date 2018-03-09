//
//  NetWorkAsstaint.m
//  demo1
//
//  Created by liuwei on 2018/3/7.
//  Copyright © 2018年 liuwei. All rights reserved.
//


#import "NetWorkAsstaint.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "MBProgressHUD+ZC.h"
#import "CheckVersion.h"
#import "Macro.h"

@protocol NetWorkProxy <NSObject>

@optional
/******AFN 内部的数据访问方法*******/
- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                  uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                                downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
                                         success:(void (^)(NSURLSessionDataTask *, id))success
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;
@end

@interface NetWorkAsstaint ()<NSURLSessionDelegate,NetWorkProxy>

@end

@implementation NetWorkAsstaint

+(instancetype)sharedAssistaint{
    static NetWorkAsstaint * instance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] initWithBaseURL:[NSURL URLWithString:NetWorkBaseUrl]];
    });
    return instance;
}

-(instancetype)initWithBaseURL:(NSURL *)baseUrl{
    self = [super initWithBaseURL:baseUrl];
    if (self) {
        [self.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            if (status == AFNetworkReachabilityStatusNotReachable) {
                [MBProgressHUD showWithTitle:@"当前无网络连接"];
            }
        }];
        [self.reachabilityManager startMonitoring];
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        self.requestSerializer.timeoutInterval = 20;
        [self.requestSerializer setValue:[NSString stringWithFormat:@"%@",[UIDevice currentDevice].identifierForVendor] forHTTPHeaderField:@"APP-UDID"];
        
        //设置请求头
        
        //检查版本更新
        [[CheckVersion sharedCheckVersion] isUpdateAPP:APPID];
        
        self.responseSerializer = [AFHTTPResponseSerializer serializer];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain",@"text/html",nil];
        
    }
    return self;
}

-(void)requestDataByMethod:(RequestMethod)requestMethod url:(NSString *)url params:(NSDictionary *)params hud:(NSString *)hud finishBlock:(void (^)(id, NSError *))finishBlock{
    if (!url.length) {
        finishBlock(nil,nil);
        return;
    }
    if (hud.length) {
        [MBProgressHUD showWithTitle:hud];
    }
    NSString * methodName = @"";
    switch (requestMethod) {
        case GET:
            methodName = @"GET";
            break;
        case POST:
            methodName = @"POST";
        default:
            break;
    }
    
    [self dataTaskWithHTTPMethod:methodName URLString:url parameters:params uploadProgress:nil downloadProgress:nil success:^(NSURLSessionDataTask * task, id responseObject) {
        [MBProgressHUD disMiss];
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSInteger  code = [[dict objectForKey:@"code"] integerValue];
        NSDictionary * data = [dict objectForKey:@"result"];
        if (code == 200) {
            //请求成功
            finishBlock(data,nil);
        }else if (code == 403){
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        [MBProgressHUD showWithTitle:@"request failed"];
        finishBlock(nil, error);
    }];
    
}

-(void)requestNetWithMethod:(RequestMethod)requestMesthod url:(NSString *)url params:(NSDictionary *)params hud:(NSString *)hud finishBlock:(void (^)(id, NSError *))finishBlock{
    if (!url.length) {
        finishBlock(nil,nil);
        NSLog(@"缺少网络接口");
        return;
    }
    
    if (hud.length) {
        [MBProgressHUD showWithTitle:hud];
    }
    
    NSString * requestType = @"";
    switch (requestMesthod) {
        case GET:
            requestType = @"GET";
            break;
        case POST:
            requestType = @"POST";
        default:
            break;
    }
    
    AFHTTPSessionManager * requestManager = [AFHTTPSessionManager manager];
    if ([requestType  isEqualToString:@"GET"]) {
        [requestManager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"网络请求成功");
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            NSInteger code = [[dict objectForKey:@"code"] integerValue];
            NSDictionary * data = [dict objectForKey:@"result"];
            if (code == 200) {
                finishBlock(data,nil);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"网络请求失败：%@",error.debugDescription);
            finishBlock(nil,error);
        }];
    }else if ([requestType isEqualToString:@"POST"]){
        [requestManager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"网络请求失败");
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            NSInteger code = [[dict objectForKey:@"code"] integerValue];
            NSDictionary * data = [dict objectForKey:@"result"];
            if (code == 200) {
                finishBlock(data,nil);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"网络请求失败：%@",error.debugDescription);
        }];
    }
}









@end
