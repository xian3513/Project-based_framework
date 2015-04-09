//
//  UIImageView+WebCache.m
//  duobao
//
//  Created by kt on 15/4/7.
//  Copyright (c) 2015年 Duobao. All rights reserved.
//

#import "UIImageView+WebCache.h"
#import "MBOURLSession.h"
@implementation UIImageView (WebCache)

- (void)mbo_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder{
    self.image = placeholder;
//    MBOURLSession *session = [[MBOURLSession alloc]init];
//    [session GETWithURL:url];
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:4];
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    self.image = [UIImage imageWithData:received];
    [[NSUserDefaults standardUserDefaults] setObject:received forKey:[NSString stringWithFormat:@"http://%@%@",url.host,url.path]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
