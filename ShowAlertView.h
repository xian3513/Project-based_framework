//
//  ToastView.h
//  duobao
//
//  Created by kt on 15/3/18.
//  Copyright (c) 2015年 Duobao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBOHeaderfile.m"
#import "NSString+Extension.h"
@interface ShowAlertView : NSObject
//@property (nonatomic,assign,readonly) BOOL indicatorIsAnimating;
+ (void)showToastViewWithText:(NSString *)text;
+ (void)showHudView;
+ (void)stopHudView;
@end
