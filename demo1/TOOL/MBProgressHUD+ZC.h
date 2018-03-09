//
//  MBProgressHUD+ZC.h
//  Pods
//
//  Created by Zonetry on 16/7/8.
//
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (ZC)

/**
 *  纯文字提示,2秒后自动消失
 *
 *  @param title 提示内容
 */
+(void)showWithTitle:(NSString *)title;

/**
 *  文字,图片的成功和失败的提示,2秒后自动消失
 *
 *  @param title   提示的文字,不传的时候,只显示图片
 *  @param success 成功 或 失败
 */
+(void)showWithImgaeAndTitle:(NSString *)title ForSuccess:(BOOL)success;

/**
 *  转菊花,显示当前的状态
 *
 *  @param status 当前的状态,不传的时候,只显示转菊花
 */
+(void)showWithStatus:(NSString *)status;

/**
 *  消失
 */
+(void)disMiss;

@end
