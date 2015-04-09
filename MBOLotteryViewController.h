//
//  MBOLotteryViewController.h
//  duobao
//
//  Created by kt on 15/3/31.
//  Copyright (c) 2015年 Duobao. All rights reserved.
//

#import "MBOBaseViewController.h"
#import "Global+write.h"//也可以考虑把全局对象的写权限 开给delegate，这样需要考虑整个项目需要全局数据的量（目前只有该类有global的写权限）
static NSString *menuIdentifer = @"menuIdentifer";
static NSString *lottDataIdentifer = @"lottDataIdentifer";

typedef void (^MBOLottoryBlock)(NSData *data, NSString *identifer);

@interface MBOLotteryViewController : MBOBaseViewController

@property (nonatomic,assign)MBOLottoryBlock HTTPSuccess;

- (void)MBOLotteryHTTPRequest:(MBOBaseModel *)model identifer:(NSString *)identifer;
- (void)cancelHTTPConnectioning:(NSString *)identifer;

#warning   网络请求后回调，子类实现方法。
- (void)MBOLotteryHTTPSuccessWithData:(NSData *)data identifer:(NSString *)identifer;
- (void)MBOLotteryHTTPFailWithStatusCode:(NSInteger )statusCode identifer:(NSString *)identifer;

@end
