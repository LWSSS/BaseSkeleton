//
//  MBProgressHUD+ZC.m
//  Pods
//
//  Created by Zonetry on 16/7/8.
//
//

#import "MBProgressHUD+ZC.h"

@implementation MBProgressHUD (ZC)

/**
 *  纯文字提示,2秒后自动消失
 *
 *  @param title 提示内容
 */
+(void)showWithTitle:(NSString *)title
{
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.detailsLabelText=title;
    hud.margin=5;
    hud.cornerRadius=4.0;
    hud.mode=MBProgressHUDModeText;
    [hud hide:YES afterDelay:2.0f];
}

/**
 *  成功或失败,图片提示
 *
 *  @param success 成功 或 失败
 */
+(MBProgressHUD *)showWithImageForSuccess:(BOOL)success
{
    UIImage *successImage=[UIImage imageNamed:@"success"];
    UIImage *errorImage=[UIImage imageNamed:@"error"];
    UIImageView *successView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, successImage.size.width, successImage.size.height)];
    successView.image=successImage;
    UIImageView *errorView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, errorImage.size.width, errorImage.size.height)];
    errorView.image=errorImage;
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode=MBProgressHUDModeCustomView;
    hud.cornerRadius=4.0f;
    hud.margin=15;
    if (success) {
        hud.customView=successView;
    }else{
        hud.customView=errorView;
    }
    [hud hide:YES afterDelay:2.0f];
    return hud;
}

/**
 *  文字,图片的成功和失败的提示
 *
 *  @param title   提示的文字,不传的时候,只显示图片
 *  @param success 成功 或 失败
 */
//+(void)showWithImgaeAndTitle:(NSString *)title ForSuccess:(BOOL)success
//{
//    MBProgressHUD *hud=[MBProgressHUD showWithImageForSuccess:success];
//    if ([title isNotBlank]) {
//        hud.detailsLabelText=title;
//    }
//}

/**
 *  转菊花,显示当前的状态
 *
 *  @param status 当前的状态
 */
//+(void)showWithStatus:(NSString *)status
//{
//    if (![UIApplication sharedApplication].keyWindow) {
//        return;
//    }
//    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
//    hud.labelText=status;
//    hud.cornerRadius=4.0f;
//    hud.margin=20;
//    [[WTManager new] afterDelay:40.0f run:^{
//         NSArray *allHuds=[MBProgressHUD allHUDsForView:[UIApplication sharedApplication].keyWindow];
//        if (allHuds.count > 0) {
//            for(MBProgressHUD *hudView in allHuds){
//                [hudView hide:YES];
//                [hudView removeFromSuperview];
//            }
//        }
//    }];
//}

/**
 *  消失
 */
+(void)disMiss
{
    if (![UIApplication sharedApplication].keyWindow) {
        return;
    }
    NSArray *allHuds=[MBProgressHUD allHUDsForView:[UIApplication sharedApplication].keyWindow];
    MBProgressHUD *hud=[allHuds lastObject];
    [hud hide:YES];
    hud=nil;
}

@end
