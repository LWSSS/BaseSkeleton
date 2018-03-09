//
//  CheckVersion.h
//  demo1
//
//  Created by liuwei on 2018/3/8.
//  Copyright © 2018年 liuwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckVersion : NSObject

+(CheckVersion *)sharedCheckVersion;

-(void)isUpdateAPP:(NSString *)appid;

@end
