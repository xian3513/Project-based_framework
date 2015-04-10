//
//  DuobaoBaseViewController1.m
//  duobao
//
//  Created by kt on 15/3/13.
//  Copyright (c) 2015年 Duobao. All rights reserved.
//

#import "MBOBaseViewController.h"

@interface MBOBaseViewController ()

@end

@implementation MBOBaseViewController {
    CGFloat paomaHeight;
}
@synthesize paomaHeight;

- (void)initData {
    
    //基本数据init
    paomaHeight = 16;
    toolBarheight = 44;
    defaultViewHeight = 44+44;
    statusBarAndNavBarHeight=20+44;
    
    
    //网络请求对象
    if(!self.HTTPRequest) {
        self.HTTPRequest = [[MBOHTTPRequest alloc]init];
    }
    //全局变量
    if(!_global) {
        _global = [Global share];
    }
    
    
    //跑马灯
    
    _paomaView = [[PaomaView alloc]initWithFrame:CGRectMake(0, statusBarAndNavBarHeight, screenWidth, paomaHeight)];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        [self initData];
    }
    return self;
}

- (id)init {
    if(self = [super init]) {
        [self initData];
    }
    return self;
}


#pragma - base
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //nav -> barColor
    UIColor * color = [UIColor colorWithRed:112.0/255.0 green:168.0/255.0 blue:0/255.0 alpha:1];
    [self.navigationController.navigationBar setBarTintColor:color];
    //nav -> back
    color = [UIColor whiteColor];
    [self.navigationController.navigationBar setTintColor:color];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)dealloc {
    self.HTTPRequest = nil;
    
}

#pragma - 跑马灯
- (void)paomaViewStartShowBeforeWithDuration:(NSTimeInterval)duration beforeAnimation:(void (^)())before inView:(UIView *)view {
    [UIView animateWithDuration:duration animations:^{
        before();
    } completion:^(BOOL isFinished){
        [self.paomaView showInView:view];
    }];
}

- (void)paomaVIewStopShowWithDuration:(NSTimeInterval)duration completion:(void (^)())completion {
    [self.paomaView stopShow];
    [UIView animateWithDuration:duration animations:^(){
        completion();
    }];
}

#pragma - 后台异步处理数据方法封装
- (void)backgroundDataProcessingWithIdentifer:(char *)identifer process:(void (^)())process finish:(void (^)(BOOL, NSString *))finish{
   __block BOOL isFinish = NO;
    dispatch_queue_t network_queue;
    network_queue = dispatch_queue_create(identifer, nil);
    dispatch_async(network_queue, ^{
        process();
        isFinish = YES;
    dispatch_async(dispatch_get_main_queue(), ^{
        finish(isFinish,[[NSString alloc] initWithCString:identifer encoding:NSUTF8StringEncoding]);
    });
    });
}

- (void)MBOViewControllerReloadData:(NSData *)data {
    NSLog(@"%s   dosomething"  ,__FUNCTION__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
