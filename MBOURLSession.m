//
//  MBOURLSession.m
//  duobao
//
//  Created by kt on 15/4/1.
//  Copyright (c) 2015年 Duobao. All rights reserved.
//

#import "MBOURLSession.h"

@implementation MBOURLSession {
    NSData *partialData;
}

- (NSURLSession *)session {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    return [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
}

- (NSMutableURLRequest *)request:(NSString *)strUrl {
 return [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strUrl]];
}

- (void)GET:(NSString *)strUrl {
    [self GETWithURL:[NSURL URLWithString:strUrl]];
}

- (void)GETWithURL:(NSURL *)url {
    self.task = [[self session] downloadTaskWithRequest:[NSMutableURLRequest requestWithURL:url]];
    [self.task resume];
}

- (void)stopGET {

}

- (void)pauseGET {
    if(self.task) {
        [self.task cancelByProducingResumeData:^(NSData *data){
            partialData = data;
            self.task = nil;
        }];
    }
}

- (void)resumeGET:(NSString *)strUrl {
    if(!self.task) {
        if(partialData) {
        self.task = [[self session] downloadTaskWithResumeData:partialData];
        } else {
            self.task = [[self session] downloadTaskWithRequest:[self request:strUrl]];
        }
    }
    [self.task resume];
}

//创建文件本地保存目录
-(NSURL *)createDirectoryForDownloadItemFromURL:(NSURL *)location
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *urls = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *documentsDirectory = urls[0];
    return [documentsDirectory URLByAppendingPathComponent:[location lastPathComponent]];
}
//把文件拷贝到指定路径
-(BOOL) copyTempFileAtURL:(NSURL *)location toDestination:(NSURL *)destination
{
    
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtURL:destination error:NULL];
    [fileManager copyItemAtURL:location toURL:destination error:&error];
    if (error == nil) {
        return true;
    }else{
        NSLog(@"%@",error);
        return false;
    }
}
#pragma -- NSURLSessionDownloadDelegate
- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session {
    NSLog(@"%@",NSStringFromSelector(_cmd));
}
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location {
    
    //下载成功后，文件是保存在一个临时目录的，需要开发者自己考到放置该文件的目录
    NSLog(@"Download success for URL: %@",location.description);
    NSURL *destination = [self createDirectoryForDownloadItemFromURL:location];
    BOOL success = [self copyTempFileAtURL:location toDestination:destination];
    
    if(success){
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"destination:%@",[destination path]);
            self.HTTPSuccess([NSData dataWithContentsOfFile:[destination path]]);
        });
    }else{
        NSLog(@"Meet error when copy file");
    }
    self.task = nil;
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    _currentProgressing = totalBytesWritten/(double)totalBytesExpectedToWrite;
    NSLog(@"currentProgressing:%f",self.currentProgressing);
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
 didResumeAtOffset:(int64_t)fileOffset
expectedTotalBytes:(int64_t)expectedTotalBytes {

}

@end
