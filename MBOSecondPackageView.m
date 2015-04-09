//
//  MBOSecondPackageView.m
//  duobao
//
//  Created by kt on 15/3/23.
//  Copyright (c) 2015年 Duobao. All rights reserved.
//

#import "MBOSecondPackageView.h"

@implementation MBOSecondPackageView

- (id)initWithFrame:(CGRect)frame {
    if(self =[super initWithFrame:frame]) {
        if(!_global) {
            _global = [Global share];
        }
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
