//
//  MBOBaseView.m
//  duobao
//
//  Created by kt on 15/3/21.
//  Copyright (c) 2015年 Duobao. All rights reserved.
//

#import "XISBaseView.h"

static char XISActionHandlerTapGestureKey;
static char XISActionHandlerTapBlockKey;
@implementation XISBaseView

- (id)init {
    if(self = [super init]) {
     self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setTapActionWithBlock:(void (^)(void))block {
    self.userInteractionEnabled = self;
    UITapGestureRecognizer *tap = objc_getAssociatedObject(self, &XISActionHandlerTapGestureKey);
    if(!tap) {
        tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleActonForTapGesture:)];
        [self addGestureRecognizer:tap];
        objc_setAssociatedObject(self, &XISActionHandlerTapGestureKey, tap,  OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &XISActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)handleActonForTapGesture:(UITapGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        void(^action)(void) = objc_getAssociatedObject(self, &XISActionHandlerTapBlockKey);
        if (action) {
            action();
        }
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
