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
    toolBarheight = 44;
    defaultViewHeight = 44+44;
    statusBarAndNavBarHeight=20+44;
    
    if(!self.HTTPRequest) {
        self.HTTPRequest = [[MBOHTTPRequest alloc]init];
    }
    paomaHeight = 16;
    if(!_global) {
        _global = [Global share];
    }
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

- (void)dealloc {
    self.HTTPRequest = nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
