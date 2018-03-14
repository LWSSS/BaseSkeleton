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
    self.view.backgroundColor = [UIColor whiteColor];
    NSString * string = @"1234567";
    NSString * md5Str = [[BaseTool sharedTool] md5:string];
    NSLog(@"md5String:%@",md5Str);
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
