//
//  MBOBaseView.h
//  duobao
//
//  Created by kt on 15/3/21.
//  Copyright (c) 2015年 Duobao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "XISHeaderfile.h"
@interface XISBaseView : UIView

- (void)setTapActionWithBlock:(void(^)(void))block;
@end
