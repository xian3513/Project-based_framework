//
//  PaomaView.h
//  duobao
//
//  Created by kt on 15/3/21.
//  Copyright (c) 2015年 Duobao. All rights reserved.
//

#import "MBOBaseView.h"

typedef enum {
    moveToleft=0,
    moveToRight
} moveDirection;

@interface PaomaView : MBOBaseView

@property (nonatomic,assign) moveDirection direction;
@property (nonatomic,strong) UIColor *textColor;
@property (nonatomic,copy) NSString *showText;
@property (nonatomic,assign) CGFloat ratio;

- (void)cardSwitchAnimation;
- (void)cardSwitchStop;
- (void)moveInView:(UIView *)view;
- (void)stopMove;

@end
