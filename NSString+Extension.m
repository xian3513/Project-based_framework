//
//  NSString+Extension.m
//  duobao
//
//  Created by kt on 15/3/31.
//  Copyright (c) 2015年 Duobao. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (CGSize)sizeWithSystemFontMaxSize:(CGSize)maxSize {
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:[UIFont labelFontSize]]};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin
                           attributes:attrs context:nil].size;
}
@end
