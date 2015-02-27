//
//  ViewController.m
//  01-美团HD
//
//  Created by yake on 15-2-25.
//  Copyright (c) 2015年 yake. All rights reserved.
//

#import "ViewController.h"
#import "DPRequest.h"
#import "DPAPI.h"
#import "PrefixHeader.pch"
@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableDictionary * paramGz = [NSMutableDictionary dictionary];
    paramGz[@"city"] = @"广州";
    // 单例不会被释放么？
    [[DPAPI sharedInstance] request:@"v1/business/find_businesses" params:paramGz success:^(id json) {
        YKLog(@"广州请求成功");
    } failure:^(NSError *error) {
        YKLog(@"广州请求失败");
    }];
    
    NSMutableDictionary * paramBj = [NSMutableDictionary dictionary];
    paramBj[@"city"] = @"北京";
    [[DPAPI sharedInstance] request:@"v1/business/find_businesses" params:paramBj success:^(id json) {
        YKLog(@"北京请求成功");
    } failure:^(NSError *error) {
        YKLog(@"北京请求失败");
    }];
//    [api requestWithURL:@"v1/business/find_businesses" params:params delegate:self];
    
}


@end
