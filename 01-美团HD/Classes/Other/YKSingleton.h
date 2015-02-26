//
//  YKSingleton.h
//  01-美团HD
//
//  Created by yake on 15-2-26.
//  Copyright (c) 2015年 yake. All rights reserved.
//

#define YKSingleton_H + (instancetype)sharedInstance;

#define YKSingleton_M \
static id _instance; \
+ (instancetype)allocWithZone:(struct _NSZone *)zone \
{ \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instance = [super allocWithZone:zone]; \
    }); \
    return _instance; \
} \
+ (instancetype)sharedInstance \
{ \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instance = [[self alloc] init]; \
    }); \
    return _instance; \
}