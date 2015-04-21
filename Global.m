//
//  GlobeModel.m
//  duobao
//
//  Created by kt on 15/3/18.
//  Copyright (c) 2015年 Duobao. All rights reserved.
//

#import "Global.h"
@implementation Global

#warning 需要补全单例 其他方法,目前已经确保了大部分操作的唯一对象
+ (Global *)share {
    static dispatch_once_t predicate;
    static Global *singleton;
    dispatch_once(&predicate, ^{
        singleton = [[Global alloc] init];
    });
    return singleton;
}

- (NSData *)getOriginalDataWithIdentifer:(NSString *)identifer {
    NSData *data = nil;
    if(originalDictionary) {
        data = [originalDictionary objectForKey:identifer];
    }
    return data;
}

- (NSDictionary *)getLotteryDateData {
    return lotteryDateData;
}

- (NSString *)getMenuTitleWithLotteryId:(NSString *)lotteryId {
    return [menuListDictionary objectForKey:lotteryId];
}

@end
