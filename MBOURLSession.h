//
//  MBOURLSession.h
//  duobao
//
//  Created by kt on 15/4/1.
//  Copyright (c) 2015年 Duobao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^MBOURLSessionBlock)(NSData *data);
@interface MBOURLSession : NSObject<NSURLSessionDownloadDelegate>
@property (nonatomic,strong) NSURLSessionDownloadTask *task;
@property (nonatomic,copy) MBOURLSessionBlock HTTPSuccess;
@property (nonatomic,assign,readonly) double currentProgressing;
- (void)GET:(NSString *)strUrl;
- (void)GETWithURL:(NSURL *)url;

- (void)stopGET;
- (void)pauseGET;
- (void)resumeGET:(NSString *)strUrl;
@end

//session = [[MBOURLSession alloc]init];
//[session GET:@"http://p1.pichost.me/i/40/1639665.png"];