//
//  BaseTool.h
//  demo1
//
//  Created by liuwei on 2018/3/13.
//  Copyright © 2018年 liuwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^BaseRun)(void);


void  BaseMainRun(BaseRun run);

@interface BaseTool : NSObject
+(instancetype)sharedTool;
//获取当前控制器
-(UIViewController *)getCurrentViewController;
//当前屏幕截图
-(UIImage *)cutCurrentWindow:(UIView *)view;
//截取一个view
-(UIImage *)makeImageWithView:(UIView *)view withSize:(CGSize)size;
//判断是否手机号码
-(BOOL)isValidPhoneNumber:(NSString *)mobile;
//获取当前时间
-(NSString *)getCurrentTime;
//获取当前时间戳
-(NSString *)getCurrentTimeInterval;
//根据颜色创建1*1图片
-(UIImage *)createImageWithColor:(UIColor *)color;
//将时间转换为时间戳
-(long)getTimeIntervalWithTime:(NSDate *)date;
//将时间戳转换为时间
-(NSString *)getTimeWithTimeInterval:(double)timeInateval;
//字符串md5加密
-(NSString *)md5:(NSString *)input;
//sha加密
-(NSString *)sha1:(NSString *)input;

//获取当前设备型号
-(NSString *)getCurrentDeviceModel;
@end
