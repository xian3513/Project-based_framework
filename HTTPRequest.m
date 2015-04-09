//
//  MBOHTTPRequest.m
//  duobao
//
//  Created by kt on 15/3/18.
//  Copyright (c) 2015年 Duobao. All rights reserved.
//

#import "HTTPRequest.h"

NSString * const hostname =@"http://api.mbo21.com/?";

@implementation HTTPRequest {
    CGFloat dataLength;
}
- (id)init {
    if(self = [super init]) {
        URLConnectionsDictionary = [[NSMutableDictionary alloc]initWithCapacity:0];
         URLConnections = [[NSArray alloc]initWithArray:URLConnectionsDictionary.allValues];
        responsesDictionary = [[NSMutableDictionary alloc]initWithCapacity:0];
        responses = [[NSArray alloc]initWithArray:responsesDictionary.allValues];
        
        dataLength = 0.0f;
    }
    return self;
}

#pragma mark -- httpRequest
- (void)HTTPSyncGetWithURL:(NSString *)urlStr identifer:(NSString *)identifer seccess:(void (^)(NSData *))seccess fail:(void (^)(NSError *))fail {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",hostname,urlStr]];
    //第二步，通过URL创建网络请求
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5];
    //NSURLRequest初始化方法第一个参数：请求访问路径，第二个参数：缓存协议，第三个参数：网络请求超时时间（秒）
    //第三步，连接服务器
    NSError *error = nil;
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    [ShowAlertView stopHudView];
    if(!error) {
     seccess(received);
    } else {
        fail(error);
    }
   
}

- (void)HTTPGetWithModel:(MBOBaseModel *)model Identifer:(NSString *)identifer {
    model.identifer = identifer;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",hostname,model.url]];
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request addValue:@"Duobaoios" forHTTPHeaderField:@"User-Agent"];
    [self addHTTPWithHeaders:model.httpHeaders Request:request];
    //第三步，连接服务器
    MBOURLConnection *connection = [[MBOURLConnection alloc]initWithRequest:request delegate:self];
    //NSLog(@"conn:%@",conn.description);
    connection.MBOHTTPConnectionIdentifer = identifer;
    currentResponse = request;
    currentURLConnection = connection;
    [URLConnectionsDictionary setObject:connection  forKey:connection.MBOHTTPConnectionIdentifer];
    [responsesDictionary setObject:request forKey:connection.MBOHTTPConnectionIdentifer];

}

- (void)HTTPPostWithModel:(MBOBaseModel *)model Identifer:(NSString *)identifer {
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",hostname,model.url]];
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request addValue:@"Duobaoios" forHTTPHeaderField:@"User-Agent"];
    [request setHTTPMethod:@"POST"];
    [self addHTTPWithParameters:model.httpParameters Request:request];
    //第三步，连接服务器
    // NSLog(@"request:",request.URL);
    MBOURLConnection *connection = [[MBOURLConnection alloc]initWithRequest:request delegate:self];
    connection.MBOHTTPConnectionIdentifer = identifer;
    currentResponse = request;
    currentURLConnection = connection;
    [URLConnectionsDictionary setObject:connection  forKey:connection.MBOHTTPConnectionIdentifer];
    [responsesDictionary setObject:request forKey:connection.MBOHTTPConnectionIdentifer];
    [connection start];
}

- (void)addHTTPWithHeaders:(NSDictionary *)httpHeaders  Request:(NSMutableURLRequest *)request {
    if(httpHeaders) {
        for(NSString *key in httpHeaders) {
            [request addValue:[httpHeaders objectForKey:key] forHTTPHeaderField:key];
        }
    }
}

- (void)addHTTPWithParameters:(NSDictionary *)httpParameters  Request:(NSMutableURLRequest *)request {
    NSMutableArray *marr = [[NSMutableArray alloc]initWithCapacity:0];
    for(NSString *key in httpParameters) {
        [marr addObject:[NSString stringWithFormat:@"%@=%@",key,[httpParameters objectForKey:key]]];
    }
    NSString *str = [marr componentsJoinedByString:@"&"];
    [request setHTTPBody:[str dataUsingEncoding:NSUTF8StringEncoding]];
}

#warning 有待测试
- (void)cancelHTTPConnectioning:(NSString *)identifer {
    MBOURLConnection *connection = [URLConnectionsDictionary objectForKey:identifer];
    [connection cancel];
    [URLConnectionsDictionary removeObjectForKey:identifer];
    [responsesDictionary removeObjectForKey:identifer];
}

#pragma mark -- MBOURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSHTTPURLResponse *)response {
    MBOURLConnection *conn = (MBOURLConnection *)connection;
    conn.MBOStatusCode = response.statusCode;
    dataLength = response.expectedContentLength;
    receiveData = [NSMutableData data];
}

//接收到服务器传输数据的时候调用，此方法根据数据大小执行若干次

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [receiveData appendData:data];
    _loadProgressing = receiveData.length/dataLength;
}

//数据传完之后调用此方法
-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    MBOURLConnection *conn = (MBOURLConnection *)connection;
    if(self.httpSuccess) {
        self.httpSuccess(receiveData,conn.MBOHTTPConnectionIdentifer);
    }
    [URLConnectionsDictionary removeObjectForKey:conn.MBOHTTPConnectionIdentifer];
    URLConnections = URLConnectionsDictionary.allValues;
    [responsesDictionary removeObjectForKey:conn.MBOHTTPConnectionIdentifer];
    responses = responsesDictionary.allValues;
     NSLog(@"httpFinish - statusCode:%ld  identifer:%@",conn.MBOStatusCode,conn.MBOHTTPConnectionIdentifer);
}

//网络请求过程中，出现任何错误（断网，连接超时等）会进入此方法

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    MBOURLConnection *conn = (MBOURLConnection *)connection;
//    if(self.httpFail) {
//        self.httpFail(conn.MBOStatusCode,conn.MBOHTTPConnectionIdentifer);
//    }
    
    [URLConnectionsDictionary removeObjectForKey:conn.MBOHTTPConnectionIdentifer];
    URLConnections = URLConnectionsDictionary.allValues;
    [responsesDictionary removeObjectForKey:conn.MBOHTTPConnectionIdentifer];
    responses = responsesDictionary.allValues;
    
    [ShowAlertView stopHudView];
    [ShowAlertView showToastViewWithText:[error localizedDescription]];
    NSLog(@"/***   httpError - statusCode:%ld   ***/",conn.MBOStatusCode);
    NSLog(@"/*********   %@:%@   ***********/",conn.MBOHTTPConnectionIdentifer,[error localizedDescription]);
}

@end
