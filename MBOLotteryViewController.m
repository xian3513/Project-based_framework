//
//  MBOLotteryViewController.m
//  duobao
//
//  Created by kt on 15/3/31.
//  Copyright (c) 2015年 Duobao. All rights reserved.
//

#import "MBOLotteryViewController.h"

@interface MBOLotteryViewController ()

@end

@implementation MBOLotteryViewController {
    //在这里判断不起作用   需要添加到global里
    BOOL menuDataIsOk;
    BOOL lottDataIsOk;
    MBOBaseModel *currentModel;
    NSString *currentidentifer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //http 回调方法
    __block MBOLotteryViewController *myself = self;
    self.HTTPRequest.httpSuccess = ^(NSData *data,NSString *identifer){
        
        if([identifer isEqualToString:menuIdentifer]) {
            [myself menuParseData:data identifer:identifer];
        } else if ([identifer isEqualToString:lottDataIdentifer]) {
            [myself lottDataParseData:data identifer:identifer];
        } else { 
//            NSLog(@"%@ - %@",identifer,[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
            [myself MBOLotteryHTTPSuccessWithData:data identifer:identifer];
        }
    };
    
    self.HTTPRequest.httpFail = ^(NSInteger statusCode,NSString *identifer){
        [myself MBOLotteryHTTPFailWithStatusCode:statusCode identifer:identifer];
    };
}
#pragma HTTP请求后调用
- (void)MBOLotteryHTTPSuccessWithData:(NSData *)data identifer:(NSString *)identifer {
    [ShowAlertView stopHudView];
    NSLog(@"super HTTP Success *** identifer:%@",identifer);
}

- (void)MBOLotteryHTTPFailWithStatusCode:(NSInteger)statusCode identifer:(NSString *)identifer {
    [ShowAlertView stopHudView];
    NSLog(@"super HTTP Fail *** statusCode:%ld,identifer:%@",statusCode,identifer);
}
#pragma 对http进行了封装，确保其子类在http请求的时候 优先做全局的请求
- (void)MBOLotteryHTTPRequest:(MBOBaseModel *)model identifer:(NSString *)identifer {
   
}

- (void)cancelHTTPConnectioning:(NSString *)identifer {

}

- (void)HTTPWithModel:(MBOBaseModel *)model identifer:(NSString *)identifer {

}

- (void)HTTPForGlobalData {
    
}

- (void)globalDataSuccessed {
   
}

- (void)menuParseData:(NSData *)data identifer:(NSString *)identifer {
 
}

- (void)lottDataParseData:(NSData *)data identifer:(NSString *)identifer {
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
