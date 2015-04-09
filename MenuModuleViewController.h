//
//  BaseMenuViewController.h
//  duobao
//
//  Created by kt on 15/3/18.
//  Copyright (c) 2015年 Duobao. All rights reserved.
//

#import "MBOLotteryViewController.h"

@interface MenuModuleViewController : MBOLotteryViewController
//欢迎页
- (void)startWolcomePage:(void (^)(UIImageView *welcomeImageView))completiocn;
@end
