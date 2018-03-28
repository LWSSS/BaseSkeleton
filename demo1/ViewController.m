//
//  ViewController.m
//  demo1
//
//  Created by liuwei on 2018/3/6.
//  Copyright © 2018年 liuwei. All rights reserved.
//

#import "ViewController.h"
#import "BaseTool.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
//    NSString * string = @"1234567";
//    NSString * md5Str = [[BaseTool sharedTool] md5:string];
//    NSLog(@"md5String:%@",md5Str);
    NSString * deviceModel = [[BaseTool sharedTool] getCurrentDeviceModel];
    NSLog(@"current DeviceModel : %@",deviceModel);
    
    __block ViewController  * weakself = self;
    NSLog(@"%@",[NSDate date]);
    dispatch_time_t delayMethod = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0*NSEC_PER_SEC));
    dispatch_after(delayMethod, dispatch_get_main_queue(), ^{
        [weakself afterDelay];
    });
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//    });
//    NSLog(@"%@",[NSDate date]);
    [self performSelector:@selector(afterDelay) withObject:nil afterDelay:2];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)afterDelay{
    NSLog(@"%@",[NSDate date]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
