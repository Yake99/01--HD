//
//  DPAPI.m
//  apidemo
//
//  Created by ZhouHui on 13-1-28.
//  Copyright (c) 2013年 Dianping. All rights reserved.
//

#import "DPAPI.h"
#import "DPConstants.h"


typedef void (^DPBlock) (id result, NSError * error);
@interface DPAPI ()<DPRequestDelegate>
{
    NSMutableSet * _requests;
}
//存放所有 block;
@property (nonatomic,strong)NSMutableDictionary * blocks;
@end

@implementation DPAPI
#pragma mark - 懒加载
- (NSMutableDictionary *)blocks
{
    if(!_blocks){
        _blocks = [[NSMutableDictionary alloc] init];
    }
    return _blocks;
}

#pragma mark - 后来添加的代码
- (DPRequest *)request:(NSString *)url params:(NSDictionary *)params success:(DPSuccess)success failure:(DPFailure)failure
{
    //1.发送请求
    NSMutableDictionary * mutableParams = [NSMutableDictionary dictionaryWithDictionary:params];
    DPRequest * request = [self requestWithURL:url params:mutableParams delegate:self];
    
    //2.存储这次请求对应的block
    //每一个request对象的description是唯一的，并且是个字符串，遵守NSCOpying协议，可以作为key
    NSString * key = request.description;
    self.blocks[key] = ^(id result, NSError * error){
        if(result && success){
            success(result);
        }else if (error && failure){
            failure(error);
        }
    };
    
    //返回请求对象
    return request;
}
#pragma mark - <DPRequestDelegate>
/**
 *  请求失败
 * 
 *  @param request 请求
 *  @param error   错误信息
*/
- (void)request:(DPRequest *)request didFailWithError:(NSError *)error {
    DPBlock block = self.blocks[request.description];
    block(nil, error);
}
/**
 *  请求成功
 *
 *  @param request 请求
 *  @param error   请求结果
 */
- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result {
    DPBlock block = self.blocks[request.description];
    block(result,nil);
}
#pragma mark - 单例模式
YKSingleton_M
#pragma mark - 原来的代码
- (id)init {
	self = [super init];
    if (self) {
        _requests = [[NSMutableSet alloc] init];
    }
    return self;
}

- (DPRequest*)requestWithURL:(NSString *)url
					  params:(NSMutableDictionary *)params
					delegate:(id<DPRequestDelegate>)delegate {
	if (params == nil) {
        params = [NSMutableDictionary dictionary];
    }
    
	NSString *fullURL = [kDPAPIDomain stringByAppendingString:url];
	
	DPRequest *_request = [DPRequest requestWithURL:fullURL
											 params:params
										   delegate:delegate];
	_request.dpapi = self;
	[_requests addObject:_request];
	[_request connect];
	return _request;
}

- (DPRequest *)requestWithURL:(NSString *)url
				 paramsString:(NSString *)paramsString
					 delegate:(id<DPRequestDelegate>)delegate {
	return [self requestWithURL:[NSString stringWithFormat:@"%@?%@", url, paramsString] params:nil delegate:delegate];
}

- (void)requestDidFinish:(DPRequest *)request
{
    [_requests removeObject:request];
    request.dpapi = nil;
}

- (void)dealloc
{
    for (DPRequest* _request in _requests)
    {
        _request.dpapi = nil;
    }
}

@end
