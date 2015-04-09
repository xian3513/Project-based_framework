//
//  UIImageView+WebCache.h
//  duobao
//
//  Created by kt on 15/4/7.
//  Copyright (c) 2015年 Duobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (WebCache)
- (void)mbo_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;
@end
