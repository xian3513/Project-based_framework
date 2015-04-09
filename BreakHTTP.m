//
//  BreakHTTP.m
//  duobao
//
//  Created by kt on 15/3/20.
//  Copyright (c) 2015年 Duobao. All rights reserved.
//

#import "BreakHTTP.h"

static BreakHTTP *download;
static NSMutableDictionary *dictPath;
static NSMutableDictionary *dictBlock;
static NSMutableDictionary *dictHandle;
static unsigned long long int cacheCapacity; // 缓存
static NSMutableData *cacheData;

typedef void (^myBlcok)(NSString *savePath, NSError *error);

@interface BreakHTTP()<NSURLConnectionDataDelegate>

//测试数据 下载酷狗音乐for mac
//[BreakHTTP downLoadWithURL:@"http://www.baidu.com/link?url=K8_JEXXQnNcQzdA-UP6bRAQ4jTEwMEAl-i0d_Az8WZf9w2O1q51fHHNV6H-z0rfyMQeo9dxjMMRjktcGZrYPf6o9hSahV8yxspDzzaqzVka" toDirectory:@"dd" cacheCapacity:1000 success:^(NSString *savePath) {
//    NSLog(@"save:%@",savePath);
//} failure:^(NSError *error) {
//    NSLog(@"error:%@",error);
//}];

@end

@implementation BreakHTTP

+ (void)initialize
{
    download = [[BreakHTTP alloc] init];
    dictPath = [[NSMutableDictionary alloc] initWithCapacity:0]; // 存储文件路径
    dictBlock = [[NSMutableDictionary alloc] initWithCapacity:0]; // 存储block
    dictHandle = [[NSMutableDictionary alloc] initWithCapacity:0]; // 存储NSFileHandle对象
    cacheData = [NSMutableData data]; // 存放缓存
}

+ (NSString *) getFilePath{
    NSArray *array =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [array objectAtIndex:0];
}
+ (void)downLoadWithURL:(NSString *)urlStr toDirectory:(NSString *)toDirectory cacheCapacity:(NSInteger)capacity success:(BreakHTTPSuccess)success failure:(BreakHTTPFailure)failure {
    NSLog(@"break....................");
    // 1. 创建文件
     NSString *fileName = [urlStr lastPathComponent];
     NSString *filePath = [NSString stringWithFormat:@"%@/%@%@.dmg", [self getFilePath],toDirectory, fileName];
    NSLog(@"filePath %@",filePath);
     // 记录文件起始位置
     unsigned long long int from = 0;
     if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]){ // 已经存在
         from = [[NSData dataWithContentsOfFile:filePath] length];
         NSLog(@"from:%llu",from);
     }else{ // 不存在，直接创建
         [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
     }

    // url
     NSURL *url = [NSURL URLWithString:urlStr];

     // 请求
     NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0f];
     // 设置请求头文件
     NSString *rangeValue = [NSString stringWithFormat:@"bytes=%llu-", from];
     [request addValue:rangeValue forHTTPHeaderField:@"Range"];

     // 创建连接
     NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:download];
     // 保存文章连接
     dictPath[connection.description] = filePath;
   
     // 保存block,用于回调
    myBlcok block = ^(NSString *savePath, NSError *error){
         if (error) {
             if (failure) {
                 failure(error);
             }
         }else{
              if (success) {
                success(savePath);
             }
         }
     };
     dictBlock[connection.description] = block;
    
    // 保存缓存大小
     cacheCapacity = capacity * 1024 * 1024;
    
    // 开始连接
     [connection start];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
     // 取出文章地址
     NSString *filePath = dictPath[connection.description];
     // 打开文件准备输入
     NSFileHandle *outFile = [NSFileHandle fileHandleForWritingAtPath:filePath];
     // 保存文件操作对象
    [dictHandle setObject:outFile forKey:connection.description];
     //dictHandle[connection.description] = outFile;
}
/**
  *  开始接收数据
  *
  *  @param connection 哪一个连接
  *  @param data       二进制数据
  */
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
     // 取出文件操作对象
     NSFileHandle *outFile = dictHandle[connection.description];

     // 移动到文件结尾
     [outFile seekToEndOfFile];

     // 保存数据
     [cacheData appendData:data];
    NSLog(@"cacheData:%ld",cacheData.length);
//     if (cacheData.length >= cacheCapacity) {
         // 写入文件
         [outFile writeData:data];

         // 清空数据
//         [cacheData setLength:0];
//     }
}
/**
  *  连接出错
  *
  *  @param connection 哪一个连接出错
  *  @param error      错误信息
  */
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
     // 取出文件操作对象
     NSFileHandle *outFile = dictHandle[connection.description];

     // 关闭文件操作
     [outFile closeFile];

     // 回调block
     myBlcok block = dictBlock[connection.description];

     if (block) {
         block(nil, error);
    }

    // 移除字典中
     [dictHandle removeObjectForKey:connection.description];
     [dictPath removeObjectForKey:connection.debugDescription];
     [dictBlock removeObjectForKey:connection.description];
}
/**
  *  结束加载
  *
  *  @param connection 哪一个连接
  */
 - (void)connectionDidFinishLoading:(NSURLConnection *)connection
 {
     NSLog(@"%@",NSStringFromSelector(_cmd));
     // 取出文件操作对象
     NSFileHandle *outFile = dictHandle[connection.description];

     // 关闭文件操作
     [outFile closeFile];

     // 取出路径
     NSString *savePath = [dictPath objectForKey:connection.description];

     // 取出block
     myBlcok block = dictBlock[connection.description];
 
     // 回调
     if (block) {
         block(savePath, nil);
     }
    
     // 移除字典中
     [dictHandle removeObjectForKey:connection.description];
     [dictPath removeObjectForKey:connection.debugDescription];
     [dictBlock removeObjectForKey:connection.description];
}
@end
