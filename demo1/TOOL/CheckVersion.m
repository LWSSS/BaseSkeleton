//
//  CheckVersion.m
//  demo1
//
//  Created by liuwei on 2018/3/8.
//  Copyright © 2018年 liuwei. All rights reserved.
//

#import "CheckVersion.h"
#import <UIKit/UIKit.h>

@interface CheckVersion ()

@property (nonatomic, strong) NSString * appId;
@end

@implementation CheckVersion

+(CheckVersion *)sharedCheckVersion{
    static CheckVersion * check = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        check = [[CheckVersion alloc] init];
    });
    return check;
}

-(void)isUpdateAPP:(NSString *)appid{
    NSURL * appUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",appid]];
    NSString * appMeg = [NSString stringWithContentsOfURL:appUrl encoding:NSUTF8StringEncoding error:nil];
    NSDictionary * appDict = [self jsonStringToDictionary:appMeg];
    NSDictionary * appResultDict = [appDict[@"result"] lastObject];
    NSString * appNewVersion = appResultDict[@"version"];
    float NewVersion = [appNewVersion floatValue];//当前新发布的版本号
    
    NSString * bundleString = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];//当前本机运行的版本号
    float bundleVersion = [bundleString floatValue];
    
    if (bundleVersion < NewVersion) {
        self.appId = appid;
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * cancleAction = [UIAlertAction actionWithTitle:@"暂不更新" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"用户当前不更新");
            return ;
        }];
        UIAlertAction * defaultAction = [UIAlertAction actionWithTitle:@"去更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/app/id%@",self.appId]] options:nil completionHandler:^(BOOL success) {
                
            }];
        }];
        [alert addAction:cancleAction];
        [alert addAction:defaultAction];
        UIViewController * viewController = [self topViewController];
        [viewController presentViewController:alert animated:YES completion:nil];
    }
}

-(NSDictionary *)jsonStringToDictionary:(NSString *)jsonString{
    if (jsonString == nil) {
        return nil;
    }
    NSData * data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError * error ;
    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    if (error) {
        NSLog(@"JSON数据转换失败");
        return nil;
    }
    
    return dict;
}

//获取当前控制器
- (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}
@end
