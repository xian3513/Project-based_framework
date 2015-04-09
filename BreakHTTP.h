//
//  BreakHTTP.h
//  duobao
//
//  Created by kt on 15/3/20.
//  Copyright (c) 2015年 Duobao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^BreakHTTPSuccess)(NSString *savePath);
typedef void (^BreakHTTPFailure)(NSError *error);

@interface BreakHTTP : NSObject

@property (nonatomic,assign) BreakHTTPSuccess success;
@property (nonatomic,assign) BreakHTTPFailure failure;

+ (void)downLoadWithURL:(NSString *)urlStr toDirectory:(NSString *)toDirectory cacheCapacity:(NSInteger)capacity success:(BreakHTTPSuccess)success failure:(BreakHTTPFailure)failure;

@end
