//
//  DPAPI.h
//  apidemo
//
//  Created by ZhouHui on 13-1-28.
//  Copyright (c) 2013年 Dianping. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DPRequest.h"
#import "YKSingleton.h"
typedef void (^DPSuccess)(id json);
typedef void (^DPFailure)(NSError * error);

@interface DPAPI : NSObject

- (DPRequest*)requestWithURL:(NSString *)url
					  params:(NSMutableDictionary *)params
					delegate:(id<DPRequestDelegate>)delegate;

- (DPRequest *)requestWithURL:(NSString *)url
				 paramsString:(NSString *)paramsString
					 delegate:(id<DPRequestDelegate>)delegate;

// ^(id json)--> void (^)(id json)
// ^(NSError * error) -- > void (^)(NSError * error)
// block作为参数时，参数名在外面。定义block时，是这样的 void (^success)(id json)
//- (DPRequest *)request:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError * error))failure;
- (DPRequest *)request:(NSString *)url params:(NSDictionary *)params success:(DPSuccess)success failure:(DPFailure)failure;
YKSingleton_H
@end
