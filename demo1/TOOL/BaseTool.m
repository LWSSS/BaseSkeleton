//
//  BaseTool.m
//  demo1
//
//  Created by liuwei on 2018/3/13.
//  Copyright © 2018年 liuwei. All rights reserved.
//

#import "BaseTool.h"
#import <CommonCrypto/CommonDigest.h>

void BaseMainRun(BaseRun run){
    dispatch_async(dispatch_get_main_queue(), ^{
        run();
    });
}

@implementation BaseTool
+(instancetype)sharedTool{
    static BaseTool * base = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        base = [[BaseTool alloc] init];
    });
    return base;
}


-(UIViewController *)getCurrentViewController{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

//截屏
-(UIImage *)cutCurrentWindow:(UIView *)view{
    //传入self.view
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(CGRectGetWidth(view.frame), CGRectGetHeight(view.frame)), NO, 1);
    [view drawViewHierarchyInRect:CGRectMake(0, 0, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame)) afterScreenUpdates:NO];
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snapshot;
}

//截取一个view
-(UIImage *)makeImageWithView:(UIView *)view withSize :(CGSize)size{
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了，关键就是第三个参数 [UIScreen mainScreen].scale。
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(BOOL)isValidPhoneNumber:(NSString *)mobile{
    BOOL isMatch1 = false;
    BOOL isMatch2 = false;
    BOOL isMatch3 = false;
    
    if (mobile.length < 11)
    {
        NSLog(@"手机号码长度不够");
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        isMatch3 = [pred3 evaluateWithObject:mobile];
        
    }
    if (isMatch1 || isMatch2 || isMatch3) {
        return YES;
    }else{
        NSLog(@"请输入正确的手机号");
        return NO;
    }
}

-(NSString *)getCurrentTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *datenow = [NSDate date];
    //----------将nsdate按formatter格式转成nsstring
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    NSLog(@"currentTimeString =  %@",currentTimeString);
    return currentTimeString;
}

-(NSString *)getCurrentTimeInterval{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    return timeSp;
}

//根据颜色创建1*1图片
-(UIImage *)createImageWithColor:(UIColor *)color{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

//获取当前时间的时间戳
-(long)getTimeIntervalWithTime:(NSDate *)date{
    NSDateFormatter * formate = [[NSDateFormatter alloc] init];
    [formate setDateStyle:NSDateFormatterMediumStyle];
    [formate setTimeStyle:NSDateFormatterShortStyle];
    [formate setDateFormat:@"YY-MM-dd HH:mm:ss"];
    NSTimeZone * timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formate setTimeZone:timeZone];
    NSDate * dateNow = [NSDate  date];
    NSString * timeNowStr = [formate stringFromDate:dateNow];
    NSLog(@"timeNow:%@",timeNowStr);
    
    return [dateNow timeIntervalSince1970];
}

//根据时间戳转换时间
-(NSString *)getTimeWithTimeInterval:(double)timeInateval{
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:timeInateval];
    NSDateFormatter * dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"YY-MM-dd HH:mm:ss"];
    NSString * timeString = [dateFormater stringFromDate:date];
    return timeString;
}

//md5加密
-(NSString *)md5:(NSString *)input{
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return  output;
}

//sha1加密
//-(NSString *)sha1:(NSString *)input{
//    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
//
//    NSData *data = [NSData dataWithBytes:cstr length:self.length];
//    //使用对应的CC_SHA1,CC_SHA256,CC_SHA384,CC_SHA512的长度分别是20,32,48,64
//    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
//    //使用对应的CC_SHA256,CC_SHA384,CC_SHA512
//    CC_SHA1(data.bytes, data.length, digest);
//
//    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
//
//    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
//        [output appendFormat:@"%02x", digest[i]];
//
//    return output;
//}


@end
