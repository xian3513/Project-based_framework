//
//  MBOBaseModel.h
//  duobao
//
//  Created by kt on 15/3/13.
//  Copyright (c) 2015年 Duobao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XISHeaderfile.h"
#import <objc/runtime.h>
@interface MBOBaseModel : NSObject

@property (nonatomic,copy) NSString *url;
@property (nonatomic,copy) NSString *identifer;
@property (nonatomic,copy) NSString *HTTPTheWay;
@property (nonatomic,strong) NSMutableDictionary *httpHeaders;
@property (nonatomic,strong) NSMutableDictionary *httpParameters;
@property (nonatomic,assign) BOOL hidesShowViewWhenHTTP;
//目前model类方法用于逻辑处理
+ (id)parseJSON:(NSData *)data identifer:(NSString *)identifier;
+ (NSString *)parseSyntaxError:(NSData *)data identifer:(NSString *)identifier;
+ (NSString *)parsePrompt:(NSData *)data identifer:(NSString *)identifier;
+ (NSArray *)filterPropertys;

//一些比较耗时的操作可以放在该方法里处理，不堵塞主线程
- (void)backgroundDataProcessingWithIdentifer:(char *)identifer process:(void(^)())process finish:(void(^)(NSString *identifer))finish;


#pragma mark -- 子类去实现
- (NSData *)HTTPTestData;
@end
