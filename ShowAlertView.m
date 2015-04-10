//
//  ToastView.m
//  duobao
//
//  Created by kt on 15/3/18.
//  Copyright (c) 2015年 Duobao. All rights reserved.
//

#import "ShowAlertView.h"
#import <CoreText/CoreText.h>

@implementation ShowAlertView {
    UIActivityIndicatorView *indicator;
    CALayer * rootLayer;
    CGFloat showTime;
}

+ (ShowAlertView *)share {
    static ShowAlertView *share = nil;
    if(!share) {
        UIWindow * window = [UIApplication sharedApplication].keyWindow;
        share = [[ShowAlertView alloc]init];
        share->showTime = 3.0f;
        
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
        //设置显示样式,见UIActivityIndicatorViewStyle的定义
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        //设置背景色
        indicator.backgroundColor = MBOBackgroundColor;
        //设置背景透明
        indicator.alpha = 0.5;
        [indicator setCenter:window.center];
        //设置背景为圆角矩形
        indicator.layer.cornerRadius = 6;
        indicator.layer.masksToBounds = YES;
        share->indicator = indicator;
        
    }
    return share;
}
#pragma -- toastView
+ (void)showToastViewWithText:(NSString *)text {
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    NSArray * windows = [UIApplication sharedApplication].windows;
    if ([windows count] > 1) {
        for (UIWindow * win in windows) {
            if (win.windowLevel == 10 || win.windowLevel == 1) {
                window = win;
                break;
            }
        }
    }
    UIViewController * rootVC = window.rootViewController;
    [self showToastText:text inViewController:rootVC];
    
}


+ (void)showToastText:(NSString *)text inViewController:(UIViewController *)viewController {
    if (!text || [text length] == 0) {
        return;
    }
    ShowAlertView *share = [self share];
    if (share->indicator.isAnimating) {
        [share->indicator stopAnimating];
    }
    CALayer * layer = [CALayer layer];
        // Background layer
        CALayer * rootLayer = viewController.view.layer;
        share->rootLayer = rootLayer;
        [rootLayer addSublayer:layer];
    // Text layer
    UIColor * color = [UIColor grayColor];
    [layer setBackgroundColor:color.CGColor];
    [layer setCornerRadius:5];
    [layer setOpacity:0.9f];
    [layer setFrame:CGRectZero];
    [layer setHidden:YES];
    CATextLayer * textLayer = [CATextLayer layer];
    [layer addSublayer:textLayer];
    [textLayer setString:text];
    [textLayer setContentsScale:[UIScreen mainScreen].scale];
    [textLayer setWrapped:YES];
    color = [UIColor whiteColor];
    [textLayer setForegroundColor:color.CGColor];
    const CGFloat fontSize = [UIFont labelFontSize];
    [textLayer setFontSize:fontSize];
    
    NSString * const fontName = @"HelveticaNeue-Light";
    CTFontRef fontRef = CTFontCreateWithName((__bridge CFStringRef)fontName,
                                             fontSize,
                                             nil);
    [textLayer setFont:fontRef];
    
    UIFont * font = [UIFont fontWithName:fontName size:fontSize];
    NSDictionary * fontAttr = [NSDictionary dictionaryWithObject:font
                                                          forKey:NSFontAttributeName];
    
    CGSize textSize = [text sizeWithAttributes:fontAttr];
    CGSize layerSize = CGSizeMake(textSize.width * 1.6f, textSize.height * 1.1f);
    if (layerSize.width >= share->rootLayer.frame.size.width) {
        layerSize = CGSizeMake(share->rootLayer.frame.size.width * 0.8f, CGFLOAT_MAX);
        NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin;
        textSize = [text boundingRectWithSize:layerSize
                                      options:options
                                   attributes:fontAttr
                                      context:nil].size;
        layerSize.height = textSize.height * 1.2f;
    }
    CGRect rect = CGRectMake((share->rootLayer.frame.size.width - layerSize.width) / 2,
                             (share->rootLayer.frame.size.height - layerSize.height) *0.8,
                             layerSize.width,
                             layerSize.height);
    [layer setFrame:rect];
    
    rect = CGRectMake((layer.frame.size.width - textSize.width) / 2,
                      (layer.frame.size.height - textSize.height) / 2,
                      textSize.width,
                      textSize.height);
    [textLayer setFrame:rect];
    
    // Animation
    [layer setHidden:NO];

    int64_t delta = [text length] * 0.2f * NSEC_PER_SEC;
    dispatch_time_t interval = dispatch_time(DISPATCH_TIME_NOW, delta);
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_after(interval, queue, ^{
        [CATransaction begin];
        [CATransaction setAnimationDuration:share->showTime];
        [CATransaction setValue:[NSNumber numberWithInt:0] forKey:@"opacity"];
        [CATransaction setCompletionBlock:^{
            [layer removeFromSuperlayer];
        }];
        [CATransaction commit];
    });
}

#pragma -- hudView
+ (void)showHudView {
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    ShowAlertView *share = [self share];
    [window.rootViewController.view addSubview:share->indicator];
    [share->indicator startAnimating];
}

+ (void)stopHudView {
     ShowAlertView *share = [self share];
    if([share->indicator isAnimating]) {
        [share->indicator stopAnimating];
    }
   
    
}

@end
