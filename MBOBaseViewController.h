//
//  DuobaoBaseViewController1.h
//  duobao
//
//  Created by kt on 15/3/13.
//  Copyright (c) 2015年 Duobao. All rights reserved.
//



#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "MBOHeaderfile.m"

#import "MBOHTTPRequest.h"
#import "MBOModelFactory.h"
#import "MBOBaseModel.h"
#import "ShowAlertView.h"

#import "Global.h"
#import "PaomaView.h"

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//                    1.封装了全局变量 global                                   //
//                    2.封装了跑马灯广告栏                                       //



/////////////////////////////////////////////////////////////////////////////////

@interface MBOBaseViewController : UIViewController {
    CGFloat toolBarheight;
    CGFloat defaultViewHeight;
    CGFloat statusBarAndNavBarHeight;
}

@property (nonatomic,strong) MBOHTTPRequest *HTTPRequest;
@property (nonatomic,strong,readonly) Global *global;
@property (nonatomic,strong,readonly) PaomaView *paomaView;//可以考虑是否把该对象也去掉??
@property (nonatomic,assign,readonly) CGFloat paomaHeight;

//跑马灯相关
- (void)paomaViewStartShowBeforeWithDuration:(NSTimeInterval)duration beforeAnimation:(void(^)())before inView:(UIView *)view;
- (void)paomaVIewStopShowWithDuration:(NSTimeInterval)duration completion:(void(^)())completion;

//一些比较耗时的操作可以放在该方法里处理，不堵塞主线程
- (void)backgroundDataProcessingWithIdentifer:(char *)identifer process:(void(^)())process finish:(void(^)(BOOL isFinish,NSString *identifer))finish;

#pragma mark -- 子类去实现
- (void)MBOViewControllerReloadData:(NSData *)data;
@end
